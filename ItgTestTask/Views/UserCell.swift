//
//  UserCell.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet var userName: UILabel!
    
    override func awakeFromNib() {
        print()
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
