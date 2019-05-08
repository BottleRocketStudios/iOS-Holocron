//
//  ContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

import Foundation
@testable import Holocron
import KeychainAccess
import XCTest

// MARK: StorageProviderTester
/// Used to uniformly run tests on a variety of storage providers.
struct StorageProviderTester {
    let provider: StorageProvider
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
    }
    
    func runTests() throws {
        try test_storeInt()
        try test_storeDouble()
        try test_storeFloat()
        try test_storeString()
        try test_storeURL()
        try test_storeBool()
        try test_storeCodable()
        try test_storeRawBytes()
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
    
    func test_storeRawBytes() throws {
        let value = Data(bytes: Array(0x0...0xf))
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
    }
    
    func test_negativeRetrieval() throws {
        let stored: Stored? = try provider.value(for: #function)
        XCTAssertNil(stored)
    }
}

// MARK: MockStorageProvider
class MockStorageProvider: StorageProvider {
    private var storage = [String : Data]()
    
    func deleteValue(for key: Key) throws {
        storage[key.rawValue] = nil
    }
    
    func value<T: Decodable>(for key: Key) throws -> T? {
        guard let data = storage[key.rawValue] else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    func write<T: Encodable>(_ value: T, for key: Key) throws {
        storage[key.rawValue] = try defaultEncoded(value)
    }
}

class MockFileManager: Holocron.FileManager {
    private var storage = [String : Data]()
    
    func contents(atPath path: String) -> Data? {
        return storage[path]
    }
    
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool {
        storage[path] = data
        return true
    }
    
    func removeItem(at url: URL) throws {
        storage[url.path] = nil
    }
}

// MARK: StorageProviderTests
/// Runs tests using `StorageProviderTester` with all the storage providers that are available.
class StorageProviderTests: XCTestCase {
    func test_defaults() throws {
        try StorageProviderTester(provider: .UserDefaults()).runTests()
    }
    
    func test_mock() throws {
        try StorageProviderTester(provider: MockStorageProvider()).runTests()
    }
    
    func test_fileSystem() throws {
        let provider = FileSystemStorageProvider(baseURL: FileManager.default.temporaryDirectory, fileManager: MockFileManager())
        try StorageProviderTester(provider: provider).runTests()
    }
    
    func test_keychain() throws {
        try StorageProviderTester(provider: .Keychain()).runTests()
    }
}
