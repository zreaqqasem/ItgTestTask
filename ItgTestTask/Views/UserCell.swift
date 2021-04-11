//
//  UserCell.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    var userImage: String?
    @IBOutlet var userName: UILabel!
    var url : URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        


    }
    override func prepareForReuse() {
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    

    
}
