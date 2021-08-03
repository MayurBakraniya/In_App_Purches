//
//  ViewController.swift
//  In_App_Purches
//
//  Created by Adsum MAC 3 on 03/08/21.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    var models = [SKProduct]()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SKPaymentQueue.default().add(self)
        tableSetup()
        fatchProduct()
    }
    
    // MARK: TableSetup
    func tableSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.lbl.text = "\(product.localizedTitle): \(product.localizedDescription) - \(String(describing: product.priceLocale.currencySymbol!))\(product.price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //purches
        let payment = SKPayment(product: models[indexPath.row])
        SKPaymentQueue.default().add(payment)
    }

}

extension ViewController:SKProductsRequestDelegate,SKPaymentTransactionObserver{
        
    enum product:String,CaseIterable {
        case removeAds = "com.myApp.removeAds"
        case unlockEverything = "com.myApp.everything"
        case getGems = "com.myApp.gems"
    }
    
    func fatchProduct(){
        let request = SKProductsRequest(productIdentifiers: Set(product.allCases.compactMap({ $0 .rawValue })))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.models = response.products
            self.tableView.reloadData()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({ trans in
            switch trans.transactionState{
                case .purchasing:
                    print("purchasing")
                case .purchased:
                    print("purchased")
                    SKPaymentQueue.default().finishTransaction(trans)
                case .failed:
                    print("did not purches")
                    SKPaymentQueue.default().finishTransaction(trans)
                case .restored:
                    break
                case .deferred:
                    break
                @unknown default:
                    break
            }
        })
    }
}
