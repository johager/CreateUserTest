//
//  PasswordTests.swift
//  CreateUserTestTests
//
//  Created by James Hager on 6/21/22.
//

import XCTest
@testable import CreateUserTest

class PasswordTests: XCTestCase {
    
    var vc: ViewController!
    
    // MARK: - setUp & tearDown
    
    override func setUp() {
        vc = ViewController()
    }
    
    override func tearDown() {
        vc = nil
    }
    
    // MARK: - Tests
    
    func testAllGood1() {
        let passwd = "FooBar12!"
        let res = vc.passwdIsOK(passwd)
        XCTAssert(res, "failed \(#function), passwd: '\(passwd)'")
    }
    
    func testAllGood2() {
        let passwd = "Foo1Bar2!"
        let res = vc.passwdIsOK(passwd)
        XCTAssert(res, "failed \(#function), passwd: '\(passwd)'")
    }
    
    func testFailLength() {
        let passwd = "Fo12!"
        let res = vc.passwdIsOK(passwd)
        XCTAssert(!res, "failed \(#function), passwd: '\(passwd)'")
    }
    
    func testFailNum() {
        let passwd = "FooBar1!"
        let res = vc.passwdIsOK(passwd)
        XCTAssert(!res, "failed \(#function), passwd: '\(passwd)'")
    }
    
    func testFailCap() {
        let passwd = "foobar12!"
        let res = vc.passwdIsOK(passwd)
        XCTAssert(!res, "failed \(#function), passwd: '\(passwd)'")
    }
    
    func testFailSpec() {
        let passwd = "foobar12"
        let res = vc.passwdIsOK(passwd)
        XCTAssert(!res, "failed \(#function), passwd: '\(passwd)'")
    }
}
