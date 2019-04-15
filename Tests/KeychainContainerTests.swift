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
    
    let keychain: StorageProvider = .Keychain()
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
        
        static func ==(lhs: Stored, rhs: Stored) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
    
    func test_storeString() throws {
        let value = #function
        try keychain.write(value, for: #function)
        try XCTAssertEqual(value, keychain.value(for: #function))
    }
    
    func test_storePrimitive() throws {
        let value = #line
        try keychain.write(value, for: #function)
        try XCTAssertEqual(value, keychain.value(for: #function))
    }
    
    func test_storeCodable() throws {
        let value = Stored(id: #line, title: #function)
        try keychain.write(value, for: #function)
        try XCTAssertEqual(value, keychain.value(for: #function))
    }
    
    func test_negativeRetrieval() throws {
        let stored: Stored? = try keychain.value(for: #function)
        XCTAssertNil(stored)
    }
}
