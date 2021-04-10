//
//  UserListViewModelTest.swift
//  ItgTestTaskTests
//
//  Created by Qasem Zreaq on 10/04/2021.
//

import XCTest
@testable import ItgTestTask

class UserListViewModelTest: XCTestCase {
    var userListViewModel : UsersListVieModel!
    var userViewModel : UserViewModel!
    
    override func setUp() {
        super.setUp()
        self.userListViewModel = UsersListVieModel()
        
    }

    
    func test_the_values_of_user_list_view_model (){
       
        XCTAssertEqual(self.userListViewModel, self.userListViewModel)
        XCTAssertEqual(self.userListViewModel.usersListViewModel, self.userListViewModel.usersListViewModel)
        XCTAssertNotNil(self.userListViewModel.usersListViewModel)
    }
    
    func test_user_view_model ()
    {
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(UserViewModel.self)

        
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }


}
