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
        
        return self.user?.login ?? "No Name"
    }
    
    var location : String {
        
        return self.user?.location ?? "No Location Found"
    }
    
    var bio :String {
        
        return self.user?.bio ?? "No Bio Found"
    }
    
    var imageUrl : String {
            
        return self.user?.avatarURL ?? ""
    }
    
}
