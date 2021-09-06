//
//  Patterntext.swift
//  NewAppTests
//
//  Created by manjil on 06/09/2021.
//

import XCTest
@testable import NewApp

class PatternTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func  testCheckEmailIsInValid() {
        let isValid = Pattern.email.isAMatch(value: "test")
        
        XCTAssertFalse(isValid, "isValid should be false")
    }
    
    func  testCheckEmailIsValid() {
        let isValid = Pattern.email.isAMatch(value: "test@getnada.com")
        
        XCTAssertTrue(isValid, "isValid should be true")
    }
    
    func  testCheckEmailShouldNotMatchWithUserConstantEmail() {
        let isMatch =  "test@getnada.com".lowercased() == UserConstant.email.value.lowercased()
        
        XCTAssertFalse(isMatch, "isMatch should be false")
    }
    
    func  testCheckEmailShouldMatchWithUserConstantEmail() {
        let isMatch =  "example@gmail.com".lowercased() == UserConstant.email.value.lowercased()
    
        
        XCTAssertTrue(isMatch, "isMatch should be true")
    }
    func testCheckPasswordShouldNotMatchWithUserConstantPassword() {
        let isMatch =  "1234567" == UserConstant.password.value
        
        
        XCTAssertFalse(isMatch, "isMatch should be false")
    }
    
    func  testCheckPasswordShouldMatchWithUserConstantPassword()  {
        let isMatch =  "123456" == UserConstant.password.value
        
        
        XCTAssertTrue(isMatch, "isMatch should be true")
    }
    

}
