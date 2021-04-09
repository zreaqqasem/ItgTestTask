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
        contentView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
