//
//  DefaultsContainerTests.swift
//  Holocron-iOSTests
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Holocron
//
//class DefaultsContainerTests: XCTestCase {
//    
//    var defaults = UserDefaults.standard
//    
//    struct Stored: Codable, Equatable {
//        let id: Int
//        let title: String
//        
//        static func ==(lhs: Stored, rhs: Stored) -> Bool {
//            return lhs.id == rhs.id && lhs.title == rhs.title
//        }
//    }
//    
//    func testDefaultsContainer_storeIntSuccess() {
//        let value: Int = 5
//        let options: UserDefaults.StorageOptions = "someKey"
//        
//        defaults.store(value, with: options)
//        let stored: Int? = defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//    
//    func testDefaultsContainer_storeDoubleSuccess() {
//        let value: Double = 5.0
//        let options: UserDefaults.StorageOptions = "someKey"
//
//        defaults.store(value, with: options)
//        let stored: Double? = defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//    
//    func testDefaultsContainer_storeFloatSuccess() {
//        let value: Float = 5.0
//        let options: UserDefaults.StorageOptions = "someKey"
//
//        defaults.store(value, with: options)
//        let stored: Float? = defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//
//    func testDefaultsContainer_storeStringSuccess() {
//        let value: String = "hello world"
//        let options: UserDefaults.StorageOptions = "someKey"
//
//        defaults.store(value, with: options)
//        let stored: String? = defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//
//    func testDefaultsContainer_storeURLSuccess() {
//        let value: URL = URL(string: "http://www.google.com/")!
//        let options: UserDefaults.StorageOptions = "someKey"
//
//        defaults.store(value, with: options)
//        let stored: URL? = defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//
//    func testDefaultsContainer_storeBoolSuccess() {
//        let value = true
//        let options: UserDefaults.StorageOptions = "someKey"
//
//        defaults.store(value, with: options)
//        let stored: Bool? = defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//
//    func testDefaultsContainer_storeCodableSuccess() {
//        let value: Stored? = Stored(id: 1, title: "title")
//        let options: UserDefaults.StorageOptions = "someKey"
//
//        try! defaults.store(value, with: options)
//        let stored: Stored? = try! defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//    }
//    
//    func testDefaultsContainer_ensureFailOnNilRetrieval() {
//        let stored: Stored? = try! defaults.retrieve(with: "otherKey")
//        XCTAssertNil(stored)
//    }
//    
//    func testDefaultsContainer_manualRemoval() {
//        let value: Stored? = Stored(id: 1, title: "title")
//        let options: UserDefaults.StorageOptions = "someKey"
//        
//        try! defaults.store(value, with: options)
//        let stored: Stored? = try! defaults.retrieve(with: options)
//        XCTAssertEqual(value, stored)
//        
//        defaults.removeElement(with: options)
//        let stored2: Stored? = try! defaults.retrieve(with: options)
//        XCTAssertNil(stored2)
//    }
//}
