//
//  ValidatorTests.swift
//  CreateUserTestTests
//
//  Created by James Hager on 6/21/22.
//

import XCTest
@testable import CreateUserTest

class ValidatorTests: XCTestCase {
    
    // MARK: - Helper Methods
    
    func runUsernamesTests(on usernames: [String], useGoodEmailCheck: Bool, expectation: Bool, function: String) {
        var failed = [String]()
        
        for username in usernames {
            let res = Validator.usernameIsOK(username, useGoodEmailCheck: useGoodEmailCheck)
            if res != expectation {
                failed.append(username)
            }
        }
        
        XCTAssert(failed.count == 0, function)
        
        for fail in failed {
            print("  - \(function) - failed - '\(fail)'")
        }
    }
    
    func runPasswordsTests(on passwords: [String], expectation: Bool, function: String) {
        var failed = [String]()
        
        for password in passwords {
            let res = Validator.passwdIsOK(password)
            if res != expectation {
                failed.append(password)
            }
        }
        
        XCTAssert(failed.count == 0, function)
        
        for fail in failed {
            print("  - \(function) - failed - '\(fail)'")
        }
    }
    
    // MARK: - Username Tests
    
    func testGoodUsernamesWithSimpleCheck() {
        
        let usernames = [
            "me@gmail.com",
            "@.com"
        ]
        
        runUsernamesTests(on: usernames, useGoodEmailCheck: false, expectation: true, function: #function)
    }
    
    func testBadUsernamesWithSimpleCheck() {
        
        let usernames = [
            "megmail.com",
            "me@school.edu"
        ]
        
        runUsernamesTests(on: usernames, useGoodEmailCheck: false, expectation: false, function: #function)
    }
    
    func testGoodUsernamesWithGoodCheck() {
        
        let usernames = [
            "me@gmail.com",
            "me@school.edu",
            "me@company.co.za"
        ]
        
        runUsernamesTests(on: usernames, useGoodEmailCheck: true, expectation: true, function: #function)
    }
    
    func testBadUsernamesWithGoodCheck() {
        
        let usernames = [
            "megmail.com",
            "@gmail.com",
            "me@gmail.c",
            "me@gmail.comm"
        ]
        
        runUsernamesTests(on: usernames, useGoodEmailCheck: true, expectation: false, function: #function)
    }
    
    // MARK: - Password Tests
    
    func testGoodPasswords() {
        
        let passwords = [
            "FooBar12!",
            "Foo1Bar2!"
        ]
        
        runPasswordsTests(on: passwords, expectation: true, function: #function)
    }
    
    func testBadPasswords() {
        
        let passwords = [
            "Fo12!",
            "FooBar1!",
            "foobar12!",
            "foobar12",
            "foobar"
        ]
        
        runPasswordsTests(on: passwords, expectation: false, function: #function)
    }
}
