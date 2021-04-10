//
//  UserModel.swift
//  ItgTestTaskTests
//
//  Created by Qasem Zreaq on 10/04/2021.
//

import XCTest
@testable import ItgTestTask

class UserTest: XCTestCase {

    var user : UserInfo!
    
    override func setUp() {
        super.setUp()
        self.user = UserInfo()
        
    }

    func test_user (){
        XCTAssertNotNil(self.user)
        XCTAssertTrue(self.user.id  is Int32)
        XCTAssertTrue(self.user.login  is String)

    }
    

}
