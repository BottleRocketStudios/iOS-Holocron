//
//  FileContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

@testable import Holocron
import XCTest

class FileSystemStorageProviderTests: XCTestCase {
    func test_transformersAreCalled() throws {
        let readTransformExpectation = expectation(description: "readTransformer should be called.")
        let writeTransformExpectation = expectation(description: "writeTransformer should be called.")
        
        let value = Data(bytes: [0, 1, 2])
        
        let provider = FileSystemStorageProvider(
            baseURL: FileManager.default.temporaryDirectory,
            readTransformer: {(data) in
                readTransformExpectation.fulfill()
                return data
            },
            writeTransformer: {(data) in
                writeTransformExpectation.fulfill()
                return data
            }
        )
        
        try provider.write(value, for: #function)
        try XCTAssertEqual(provider.value(for: #function), value)
        waitForExpectations(timeout: 1)
    }
}
