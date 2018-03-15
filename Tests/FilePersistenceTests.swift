//
//  FileWriterTests.swift
//  Data PersistenceTests
//
// 
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

import XCTest
import Result
@testable import Holocron

class FilePersistenceTests: XCTestCase {
    let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    var filePersistance: FilePersistence!
    
    override func setUp() {
        filePersistance = FilePersistence(directory: cacheDirectory)
    }
    
    override func tearDown() {
        let fileManager = FileManager()
        let urls = try? fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        urls?.forEach {
            try? fileManager.removeItem(at: $0)
        }
    }
    
    func testString() {
        let textExpectation = expectation(description: "testString")
        let fileStore = FileStore(fileName: "testString")
        filePersistance.write(object: "Write This String", for: fileStore) { (result) in
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
        let textExpectation = expectation(description: "testImage")
        let fileStore = FileStore(fileName: "testInt")
        filePersistance.write(object: 12345, for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == 12345, "Failed to write int")
            case .failure(let error):
                XCTFail("Failed to write int: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testBool() {
        let textExpectation = expectation(description: "testImage")
        let fileStore = FileStore(fileName: "testBool")
        filePersistance.write(object: true, for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == true, "Failed to write bool")
            case .failure(let error):
                XCTFail("Failed to write bool: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDouble() {
        let textExpectation = expectation(description: "testImage")
        let fileStore = FileStore(fileName: "testDouble")
        let double: Double = 12345.0
        filePersistance.write(object: double, for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == 12345.0, "Failed to write double")
            case .failure(let error):
                XCTFail("Failed to write double: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFloat() {
        let textExpectation = expectation(description: "testImage")
        let fileStore = FileStore(fileName: "testFloat")
        let float: Float = 12345.0
        filePersistance.write(object: float, for: fileStore) { (result) in
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
    
    func testImage() {
        let textExpectation = expectation(description: "testImage")
        
        // Generate image
        let rect = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        UIColor.blue.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        XCTAssert(image != nil, "testImages: Failed to generate image")
        
        let data = UIImageJPEGRepresentation(image!, 1)
        
        // Create and retrieve a text file
        let fileStore = FileStore(fileName: "imageFile123456789.jpg")
        
        filePersistance.write(object: data, for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == data, "Failed to write image")
            case .failure(let error):
                XCTFail("Failed to write image: \(error)")
            }
            textExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRead() {
        let textExpectation = expectation(description: "testRead")
        
        let text = "This is a test read"
        try? text.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testRead", isDirectory: false))
        let store = FileStore(fileName: "testRead")
        filePersistance.retrieve(object: store) { (result: Result<String, StorageError>) in
            switch result {
            case .success(let object):
                XCTAssert(object == "This is a test read", "Failed to read string")
            case .failure(let error):
                XCTFail("Failed to read string: \(error)")
            }
            textExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testReadFailure() {
        let textExpectation = expectation(description: "testReadFailure")
        let store = FileStore(fileName: "testRead")
        filePersistance.retrieve(object: store) { (result: Result<String, StorageError>) in
            switch result {
            case .success(let object):
                XCTFail("Object unintended: \(object)")
            case .failure(let error):
                XCTAssert(!error.localizedDescription.isEmpty, "No error: \(error)")
            }
            textExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testWrite() {
        let textExpectation = expectation(description: "testWrite")
        let fileStore = FileStore(fileName: "testString")
        filePersistance.write(object: "Write This String", for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object == "Write This String", "Failed to write string")
                
                let url = FileManager.documentsDirectoryURL.appendingPathComponent(fileStore.fileName)
                let fileManager = FileManager()
                if fileManager.contents(atPath: url.path) != nil {
                    XCTFail("Failed to write string")
                }
            case .failure(let error):
                XCTFail("Failed to write string: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
//    func testWriteFailure() {
//        let textExpectation = expectation(description: "testWriteFailure")
//        let fileStore = FileStore(fileName: "testDict")
//        filePersistance.write(object: ["test": Formatter()], for: fileStore) { (result) in
//            switch result {
//            case .success(let object):
//                XCTFail("Object unintended: \(object)")
//            case .failure(let error):
//                XCTAssert(!error.localizedDescription.isEmpty, "No error: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
//    }
    
    func testRemove() {
        let textExpectation = expectation(description: "testRemove")
        let text = "This is a test string"
        try? text.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testString", isDirectory: false))
        let fileStore = FileStore(fileName: "testString")
        filePersistance.removeObject(for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object, "Failed to remove string")
            case .failure(let error):
                XCTFail("Failed to remove string: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRemoveFailure() {
        let textExpectation = expectation(description: "testRemoveFailure")
        let fileStore = FileStore(fileName: "testString")
        filePersistance.removeObject(for: fileStore) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object, "Unintended successful remove")
            case .failure(let error):
                XCTAssert(!error.localizedDescription.isEmpty, "No error: \(error)")
            }
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
