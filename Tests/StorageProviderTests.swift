//
//  ContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import Holocron
import XCTest

struct StorageProviderTester {
    let provider: StorageProvider
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
        
        static func ==(lhs: Stored, rhs: Stored) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
    
    func runTests() throws {
        try test_storeInt()
        try test_storeDouble()
        try test_storeFloat()
        try test_storeString()
        try test_storeURL()
        try test_storeBool()
        try test_storeCodable()
        try test_negativeRetrieval()
    }
    
    func test_storeInt() throws {
        let value = #line
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_storeDouble() throws {
        let value: Double = #line
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_storeFloat() throws {
        let value: Float = #line
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_storeString() throws {
        let value = #function
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_storeURL() throws {
        let value = URL(string: "https://developer.apple.com")!
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_storeBool() throws {
        let value = true
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_storeCodable() throws {
        let value = Stored(id: #line, title: #function)
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_negativeRetrieval() throws {
        let stored: Stored? = try provider.value(for: #function)
        XCTAssertNil(stored)
    }
}

class MockStorageProvider: StorageProvider {
    private var storage = [String : Data]()
    
    func deleteValue(for key: String) throws {
        storage[key] = nil
    }
    
    func value<T: Decodable>(for key: String) throws -> T? {
        guard let data = storage[key] else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    func write<T: Encodable>(_ value: T, for key: String) throws {
        storage[key] = try defaultEncoded(value)
    }
}

class StorageProviderTests: XCTestCase {
    func test_defaults() throws {
        try StorageProviderTester(provider: .UserDefaults()).runTests()
    }
    
    func test_mock() throws {
        try StorageProviderTester(provider: MockStorageProvider()).runTests()
    }
    
    func test_fileSystem() throws {
        try StorageProviderTester(provider: .FileSystem(baseURL: FileManager.default.temporaryDirectory)).runTests()
    }
    
    func test_keychain() throws {
        try StorageProviderTester(provider: .Keychain()).runTests()
    }
}
