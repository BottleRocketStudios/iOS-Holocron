//
//  FileWriterTests.swift
//  HolocronTests
//
//  
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

import XCTest
import Result
@testable import Holocron

class DirectoryTests: XCTestCase {
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
    
    func testEmptyDirectoryRead() {
        let textExpectation = expectation(description: "testRead")
        let store = FileStore(fileName: "testRead")
        filePersistance.retrieve(object: store) { (result: Result<String, StorageError>) in
            switch result {
            case .success(_):
                XCTFail("File exists")
            case .failure(_):
                textExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
//    func testSingleFileDirectoryRead() {
//        let textExpectation = expectation(description: "testRead")
//
//        let text = "This is a test read"
//        try? text.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testRead", isDirectory: false))
//        let store = FileStore(fileName: "testRead")
//        filePersistance.retrieve(object: store) { (result: Result<String, StorageError>) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == "This is a test read", "Failed to read string")
//            case .failure(let error):
//                XCTFail("Failed to read string: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//    }
    
//    func testMultiFileDirectoryRead() {
//        let textExpectation = expectation(description: "testRead")
//
//        let textA = "This is a test read A"
//        try? textA.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testReadA", isDirectory: false))
//        let textB = "This is a test read B"
//        try? textB.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testReadB", isDirectory: false))
//        let textC = "This is a test read C"
//        try? textC.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testReadC", isDirectory: false))
//        let store = FileStore(fileName: "testReadB")
//        filePersistance.retrieve(object: store) { (result: Result<String, StorageError>) in
//            switch result {
//            case .success(let object):
//                XCTAssert(object == "This is a test read B", "Failed to read string")
//            case .failure(let error):
//                XCTFail("Failed to read string: \(error)")
//            }
//            textExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//    }
    
    func testWriteToEmptyDirectory() {
        let fileManager = FileManager()
        let urls = try? fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        XCTAssert(urls?.count == 0, "Directory is no empty")
        
        let textExpectation = expectation(description: "testWriteToEmptyDirectory")
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
    
    func testWriteToNewFileInExistingDirectory() {
        //shouldn't delete any existing files
        
        //before: A
        //write: B
        //after: A B
        
        let text = "This is a test read"
        try? text.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testRead", isDirectory: false))
        
        let fileManager = FileManager()
        var urls = try? fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        XCTAssert(urls?.count == 1, "File did not write")
        
        let textExpectation = expectation(description: "testWriteToNewFileInExistingDirectory")
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
            urls = try? fileManager.contentsOfDirectory(at: self.cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            XCTAssert(urls?.count == 2, "Directory should have two files")
            
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testWriteToFileInNonExistentDirectory() {
        //write to A/B/C/D/file.txt --> A B C D don't exist
        let textExpectation = expectation(description: "testWriteToFileInNonExistentDirectory")
        let fileStore = FileStore(fileName: "A/B/C/D/testString")
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
            let fileManager = FileManager()
            let urls = try? fileManager.contentsOfDirectory(at: self.cacheDirectory.appendingPathComponent("A/B/C/D/"), includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            XCTAssert(urls?.count == 1, "Failed to write string")
            
            textExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRemoveFromEmptyDirectory() {
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
    
    func testRemoveFromMultiFileDirectory() {
        let textExpectation = expectation(description: "testRead")
        
        let textA = "This is a test read A"
        try? textA.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testReadA", isDirectory: false))
        let textB = "This is a test read B"
        try? textB.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testReadB", isDirectory: false))
        let textC = "This is a test read C"
        try? textC.data(using: .utf8)?.write(to: cacheDirectory.appendingPathComponent("testReadC", isDirectory: false))
        let store = FileStore(fileName: "testReadB")
        filePersistance.removeObject(for: store) { (result) in
            switch result {
            case .success(let object):
                XCTAssert(object, "Failed to remove string")
            case .failure(let error):
                XCTFail("Failed to remove string: \(error)")
            }
            let fileManager = FileManager()
            let urls = try? fileManager.contentsOfDirectory(at: self.cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            XCTAssert(urls?.count == 2, "In correct file count")
            textExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
