//
//  ProfileViewModelTest.swift
//  ItgTestTaskTests
//
//  Created by Qasem Zreaq on 10/04/2021.
//

import XCTest
@testable import ItgTestTask

class ProfileViewModelTest: XCTestCase {

    var userProfileViewModel : UserProfileViewModel!
    
    override func setUp() {
        super.setUp()
        self.userProfileViewModel = UserProfileViewModel()
        
    }
    
    func test_profile_viwe_model (){
        
        XCTAssertNotNil(self.userProfileViewModel.user)
        XCTAssertNotNil(self.userProfileViewModel.user?.login)
        XCTAssertNotNil(self.userProfileViewModel.user?.location)
        XCTAssertNotNil(self.userProfileViewModel.user?.bio)
        XCTAssertNotNil(self.userProfileViewModel.user?.avatarURL)
        XCTAssertNotNil(self.userProfileViewModel.user?.name)

    }

    override func tearDown() {
        super.tearDown()
        
    }



}
