//
//  UserNameTests.swift
//  UserNameTests
//
//  Created by James Hager on 6/21/22.
//

import XCTest
@testable import CreateUserTest

class UserNameTests: XCTestCase {
    
    var vc: ViewController!
    
    // MARK: - setUp & tearDown
    
    override func setUp() {
        vc = ViewController()
    }
    
    override func tearDown() {
        vc = nil
    }
    
    // MARK: - Test Using Simple Check
    
    func testSimpleAllGood() {
        let username = "me@gmail.com"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: false)
        XCTAssert(res, "failed \(#function), username: '\(username)'")
    }
    
    func testSimpleFailAt() {
        let username = "megmail.com"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: false)
        XCTAssert(!res, "failed \(#function), username: '\(username)'")
    }
    
    func testSimpleFailExtension() {
        let username = "me@gmail.edu"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: false)
        XCTAssert(!res, "failed \(#function), username: '\(username)'")
    }
    
    // MARK: - Test Using Good Check

    func testGoodAllGood() {
        let username = "me@gmail.com"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(res, "failed \(#function), username: '\(username)'")
    }
    
    func testGoodGoodAlternateExtension1() {
        let username = "me@school.edu"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(res, "failed \(#function), username: '\(username)'")
    }
    
    func testGoodGoodAlternateExtension2() {
        let username = "me@gmail.co"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(res, "failed \(#function), username: '\(username)'")
    }
    
    func testGoodFailAt1() {
        let username = "megmail.com"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(!res, "failed \(#function), username: '\(username)'")
    }
    
    func testGoodFailAt2() {
        let username = "@gmail.com"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(!res, "failed \(#function), username: '\(username)'")
    }
    
    func testGoodFailExtension1() {
        let username = "me@gmail.c"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(!res, "failed \(#function), username: '\(username)'")
    }
    
    func testGoodFailExtension2() {
        let username = "me@gmail.comm"
        let res = vc.usernameIsOK(username, useGoodEmailCheck: true)
        XCTAssert(!res, "failed \(#function), username: '\(username)'")
    }
}
