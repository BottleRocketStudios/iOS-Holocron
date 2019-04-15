//
//  ContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Holocron

class MockStorageProvider: StorageProvider {
    private var storage = [String : Data]()
    
    func deleteValue(for key: String) throws {
        storage[key] = nil
    }
    
    func value<T>(for key: String) throws -> T? where T : Decodable {
        guard let data = storage[key] else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    func write<T>(_ value: T, for key: String) throws where T : Encodable {
        storage[key] = try defaultEncoded(value)
    }
}

class ContainerTests: XCTestCase {
    let container = MockStorageProvider()
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
    }
    
    func test_retrieval() throws {
        let value = Stored(id: #line, title: #function)
        try container.write(value, for: #function)
        try XCTAssertEqual(value, container.value(for: #function))
    }
    
    func negativeTest_retrieval() throws {
        let nilValue: Stored? = try container.value(for: #function)
        XCTAssertNil(nilValue)
    }
    
    func test_autoUnboxing() throws {
        // first, manually store a Box<Stored> to simulate leftover data from the old Holocron
        let value = Stored(id: #line, title: #function)
        let box = Box(element: value)
        try container.write(box, for: #function)
        
        // then, ensure that the new library can properly unbox a Box<Stored> into a Stored
        try XCTAssertEqual(value, container.value(for: #function))
    }
}
