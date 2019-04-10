//
//  KeychainWriterTests.swift
//  HolocronTests
//
//  
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

import XCTest
@testable import Holocron

class KeychainPersistenceTests: XCTestCase {
    
    var keychainPersistence: KeychainPersistence!
    
    override func setUp() {
        keychainPersistence =  KeychainPersistence(keychainServiceName: "com.holocron.test")
    }
    
    func testString() {
        let textExpectation = expectation(description: "testString")
        let keyChainStore = KeychainStore(key: "testKey")
        keychainPersistence.write(object: "Write This String", for: keyChainStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == "Write This String", "Failed to write string")
            case .failure(let error):
                XCTFail("Failed to write string: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testInt() {
        let textExpectation = expectation(description: "testInteger")
        let keyChainStore = KeychainStore(key: "testKey")
        keychainPersistence.write(object: 12345, for: keyChainStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == 12345, "Failed to write Int")
            case .failure(let error):
                XCTFail("Failed to write Int: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testBool() {
        let textExpectation = expectation(description: "testBool")
        let keyChainStore = KeychainStore(key: "testKey")
        keychainPersistence.write(object: true, for: keyChainStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == true, "Failed to write Bool")
            case .failure(let error):
                XCTFail("Failed to write Bool: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDouble() {
        let textExpectation = expectation(description: "testDouble")
        let keyChainStore = KeychainStore(key: "testKey")
        keychainPersistence.write(object: 12345.0, for: keyChainStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == 12345.0, "Failed to write Double")
            case .failure(let error):
                XCTFail("Failed to write double: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFloat() {
        let textExpectation = expectation(description: "testFloat")
        let keyChainStore = KeychainStore(key: "testKey")
        keychainPersistence.write(object: 12345.0, for: keyChainStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == 12345.0, "Failed to write float")
            case .failure(let error):
                XCTFail("Failed to write float: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testData() {
        guard let data = "Hello!".data(using: .utf8) else {
            XCTFail("Failed to encode string to data")
            return
        }
        let textExpectation = expectation(description: "testData")
        let keyChainStore = KeychainStore(key: "testKey")
        keychainPersistence.write(object: data, for: keyChainStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == data, "Failed to write data")
            case .failure(let error):
                XCTFail("Failed to write data: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
//    func testRead() {
//        let textExpectation = expectation(description: "testRead")
//        let testString = "This is a test"
//        let keyChainStore = KeychainStore(key: "testKey")
//        try? keychainPersistence.write(object: testString, for: keyChainStore)
//        keychainPersistence.retrieve(object: keyChainStore) { (result: Result<String, StorageError>) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == "This is a test", "Failed to read string")
//            case .failure(let error):
//                XCTFail("Failed to read string: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
    
    func testRemove() {
        let testExpectation = expectation(description: "testRemove")
        let testString = "This is a test"
        let keyChainStore = KeychainStore(key: "testKey")
        try? keychainPersistence.write(object: testString, for: keyChainStore)
        keychainPersistence.removeObject(for: keyChainStore) { (result: Result<Bool, StorageError>) in
            switch result {
            case .success(let object):
                XCTAssert(object == true, "Failed to remove string")
            case .failure(let error):
                XCTFail("Failed to remove string: \(error)")
            }
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
