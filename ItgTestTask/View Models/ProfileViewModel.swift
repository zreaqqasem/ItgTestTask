//
//  ProfileViewModel.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 09/04/2021.
//

import Foundation

struct UserProfileViewModel {
    
    var user: Profile?
    
}

extension UserProfileViewModel {
    
    var name : String {
        
        return self.user?.login ?? NSLocalizedString("No_Name", comment: "")

    }
    
    var location : String {
        
        return self.user?.location ?? NSLocalizedString("No_Location", comment: "")
    }
    
    var bio :String {
        
        return self.user?.bio ?? NSLocalizedString("No_Bio", comment: "")
    }
    
    var imageUrl : String {
            
        return self.user?.avatarURL ?? ""
    }
    
}
