////
////  UserDefaultsWriterTests.swift
////  Data PersistenceTests
////
////  
////  Copyright © 2017 Bottle Rocket. All rights reserved.
////
//
//import XCTest
//import Result
//@testable import Holocron
//
//class UserDefaultsPersistenceTests: XCTestCase {
//    
//    var userDefaultsPersistence: UserDefaultsPersistence!
//    
//    override func setUp() {
//        userDefaultsPersistence = UserDefaultsPersistence()
//    }
//    
//    func testString() {
//        let textExpectation = expectation(description: "testString")
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        userDefaultsPersistence.write(object: "Write This String", for: userDefaultsStore) { (result) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == "Write This String", "Failed to write string")
//            case .failure(let error):
//                XCTFail("Failed to write string: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//        
//    }
//    
//    func testInteger() {
//        let textExpectation = expectation(description: "testInteger")
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        userDefaultsPersistence.write(object: 12345, for: userDefaultsStore) { (result) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == 12345, "Failed to write int")
//            case .failure(let error):
//                 XCTFail("Failed to write int: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testBool() {
//        let textExpectation = expectation(description: "testBool")
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        userDefaultsPersistence.write(object: true, for: userDefaultsStore) { (result) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == true, "Failed to write Bool")
//            case .failure(let error):
//                XCTFail("Failed to write Bool: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testDouble() {
//        let textExpectation = expectation(description: "testDouble")
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        userDefaultsPersistence.write(object: 12345.0, for: userDefaultsStore) { (result) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == 12345.0, "Failed to write Double")
//            case .failure(let error):
//                XCTFail("Failed to write Double: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testFloat() {
//        let textExpectation = expectation(description: "testFloat")
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        userDefaultsPersistence.write(object: 12345.0, for: userDefaultsStore) { (result) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == 12345.0, "Failed to write Float")
//            case .failure(let error):
//                XCTFail("Failed to write Float: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//    
//    func testRead() {
//        let textExpectation = expectation(description: "testRead")
//        let testString = "This is a test"
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        try? userDefaultsPersistence.write(object: testString, for: userDefaultsStore)
//        userDefaultsPersistence.retrieve(object: userDefaultsStore) { (result: Result<String, StorageError>) in
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
//    
//    func testRemove() {
//        let testExpectation = expectation(description: "testRemove")
//        let testString = "This is a test"
//        let userDefaultsStore = UserDefaultsStore(key: "testKey")
//        try? userDefaultsPersistence.write(object: testString, for: userDefaultsStore)
//        userDefaultsPersistence.removeObject(for: userDefaultsStore) { (result: Result<Bool, StorageError>) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == true, "Failed to remove string")
//            case .failure(let error):
//                XCTFail("Failed to remove string: \(error)")
//            }
//            testExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//}

