//
//  DefaultsContainerTests.swift
//  Holocron-iOSTests
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Holocron

class DefaultsContainerTests: XCTestCase {
    
    let defaults: StorageProvider = .UserDefaults()
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
        
        static func ==(lhs: Stored, rhs: Stored) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
    
    func test_storeInt() throws {
        let value = #line
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_storeDouble() throws {
        let value: Double = #line
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_storeFloat() throws {
        let value: Float = #line
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_storeString() throws {
        let value = #function
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_storeURL() throws {
        // the old one pointed to http://google.com, that's sacrilege :/
        let value = URL(string: "https://developer.apple.com")!
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_storeBool() throws {
        let value = true
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_storeCodable() throws {
        let value = Stored(id: #line, title: #function)
        try defaults.write(value, for: #function)
        try XCTAssertEqual(defaults.value(for: #function), value)
    }
    
    func test_negativeRetrieval() throws {
        let stored: Stored? = try defaults.value(for: #function)
        XCTAssertNil(stored)
    }
}
