//
//  KeychainContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Holocron
import KeychainAccess

class KeychainContainerTests: XCTestCase {
    
    let keychain = KeychainContainer(serviceName: "com.holocron.tests")
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
        
        static func ==(lhs: Stored, rhs: Stored) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
    
//    func testKeychainContainer_storeStringSuccess() {
//        let value: String? = "hello world"
//        try! keychain.store(value, with: "someKey")
//        let stored: String? = try! keychain.retrieve(with: "someKey")
//        XCTAssertEqual(stored, value)
//    }
//
//    func testKeychainContainer_storePrimitiveSuccess() {
//        let value: Int? = 5
//        try! keychain.store(value, with: "someKey")
//        let stored: Int? = try! keychain.retrieve(with: "someKey")
//        XCTAssertEqual(stored, value)
//    }
//
//    func testKeychainContainer_storeCodableSuccess() {
//        let value: Stored? = Stored(id: 1, title: "title")
//        try! keychain.store(value, with: "someKey")
//        let stored: Stored? = try! keychain.retrieve(with: "someKey")
//        XCTAssertEqual(stored, value)
//    }
//
//    func testKeychainContainer_ensureFailOnNilRetrieval() {
//        let stored: Stored? = try! keychain.retrieve(with: "otherKey")
//        XCTAssertNil(stored)
//    }
//
//    func testKeychainContainer_manualRemoval() {
//        let value: Stored? = Stored(id: 1, title: "title")
//        let options: KeychainContainer.StorageOptions = "someKey"
//
//        try! keychain.store(value, with: options)
//        let stored: Stored? = try! keychain.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//        
//        keychain.removeElement(with: options)
//        let stored2: Stored? = try! keychain.retrieve(with: options)
//        XCTAssertNil(stored2)
//    }
}
