//
//  TableViewCell.swift
//  In_App_Purches
//
//  Created by Adsum MAC 3 on 03/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
