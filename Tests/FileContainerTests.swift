//
//  FileContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Holocron

class FileContainerTests: XCTestCase {
    
    let file = FileContainer(fileProtectionType: .none)
    
    var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
        
        static func ==(lhs: Stored, rhs: Stored) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
    
    //MARK: Set Up / Tear Down
    override func setUp() {
        for file in try! FileManager.default.contentsOfDirectory(atPath: documentsDirectory.path) {
            try! FileManager.default.removeItem(at: documentsDirectory.appendingPathComponent(file))
        }
    }
    
    func testFileContainer_storeRawBytesSuccess() {
        let bytes = Data(bytes: [1,2,3,4,5,6,7,8])
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("testBytes"))
        try! file.store(bytes, with: options)
        
        let stored: Data? = try! file.retrieve(with: options)
        XCTAssertEqual(bytes, stored)
    }
    
    func testFileContainer_storeCodableSuccess() {
        let value = Stored(id: 3, title: "some title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("testCodable"))
        try! file.store(value, with: options)
        
        let stored: Stored? = try! file.retrieve(with: options)
        XCTAssertEqual(stored, value)
    }
    
    func testFileContainer_retrieveIntermediateDataFromStoredCodable() {
        let value = Stored(id: 3, title: "some title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("testCodable"))
        try! file.store(value, with: options)
        
        let stored: Data? = try! file.retrieve(with: options)
        XCTAssertNotNil(stored)
        XCTAssertEqual(try! stored?.defaultlyDecoded(), value)
    }
    
    func testFileContainer_ensureFailOnNilRetrieval() {
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("shouldnotExist"))
        let stored: Stored? = try! file.retrieve(with: options)
        XCTAssertNil(stored)
    }
    
    func testFileContainer_manualRemoval() {
        let value: Stored? = Stored(id: 1, title: "title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("toBeRemoved"))
        
        try! file.store(value, with: options)
        let stored: Stored? = try! file.retrieve(with: options)
        XCTAssertEqual(value, stored)
        
        file.removeElement(with: options)
        let stored2: Stored? = try! file.retrieve(with: options)
        XCTAssertNil(stored2)
    }
    
    func testFileContainer_successfulWriteToUncreatedNestedDirectory() {
        let value: Stored? = Stored(id: 1, title: "title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("a").appendingPathComponent("b").appendingPathComponent("c"))
        
        do {
            try file.store(value, with: options)
            let stored: Stored? = try file.retrieve(with: options)
            XCTAssertEqual(value, stored)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFileContainer_failsToWriteInNonDirectory() {
        let value: Stored? = Stored(id: 1, title: "title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("a"))
        try! file.store(value, with: options)
        
        do {
            let options2 = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("a").appendingPathComponent("b"))
            try file.store(value, with: options2)
            
        } catch FileContainer.Error.noParentDirectory {
            XCTAssertTrue(true)
        } catch {
            XCTFail("The wrong error was thrown - should be .noParentDirectory")
        }
    }
    
    func testFileContainer_doNotOverwriteWhenSpecified() {
        let value: Stored? = Stored(id: 1, title: "title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("a"), overwrite: false)
        try! file.store(value, with: options)
        
        let value2: Stored? = Stored(id: 2, title: "new title")
        try! file.store(value2, with: options)
        
        let stored: Stored? = try! file.retrieve(with: options)
        XCTAssertEqual(stored, value)
    }
    
    func testFileContainer_OverwriteWhenSpecified() {
        let value: Stored? = Stored(id: 1, title: "title")
        let options = FileContainer.StorageOptions(url: documentsDirectory.appendingPathComponent("a"), overwrite: true /* true is default */)
        try! file.store(value, with: options)
        
        let value2: Stored? = Stored(id: 2, title: "new title")
        try! file.store(value2, with: options)
        
        let stored: Stored? = try! file.retrieve(with: options)
        XCTAssertEqual(stored, value2)
    }
}
