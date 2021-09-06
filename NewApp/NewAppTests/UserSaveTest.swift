//
//  UserSaveTest.swift
//  NewAppTests
//
//  Created by manjil on 06/09/2021.
//

import XCTest
@testable import NewApp

class UserSaveTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserSave() {
        let user = User(email: "test@getnada.com")
        _ = UserData.save(user: user)
        
       let notNil =  UserData.get != nil
        
    XCTAssertTrue(notNil, "notNil should be true")
        
    }
    
    func testUserDeleteUser() {
        let user = User(email: "test@getnada.com")
        _ = UserData.save(user: user)
        
       _  = UserData.delete
       let isNil =  UserData.get == nil
        
    XCTAssertTrue(isNil, "isNil should be true")
        
    }
    
    func testOnly() {
        let viewModel = LandingViewModel()
        
       let value =  viewModel.loginApi()
        
        XCTAssertFalse(value.success, "success should be false")
    }

}
