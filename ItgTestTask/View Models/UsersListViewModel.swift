//
//  UsersListViewModel.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 09/04/2021.
//

import Foundation



class UsersListVieModel:Equatable {
    static func == (lhs: UsersListVieModel, rhs: UsersListVieModel) -> Bool {
        return true
    }
    
    
    var usersListViewModel :[UserViewModel]
    
    init() {
        self.usersListViewModel = [UserViewModel]()
    }
}

extension UsersListVieModel {
    
    func userViewModel (at Index : Int) -> UserViewModel{
        
        return self.usersListViewModel[Index]
    }
    
}


struct UserViewModel: Equatable {
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return true
    }
    
    
    let user:User
    
}

extension UserViewModel {
    
    var id : Int {
        
        return self.user.id
    }
    
    var name :String {
        return self.user.login
    }
    
}


