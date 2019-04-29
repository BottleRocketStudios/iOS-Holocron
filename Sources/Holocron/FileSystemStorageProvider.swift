//
//  FileSystemStorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/15/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import Foundation

public extension StorageProvider {
    typealias FileSystem = FileSystemStorageProvider
}

// MARK: Base Struct
public struct FileSystemStorageProvider {
    public typealias Transformer = (Data) -> Data
    
    let baseURL: URL
    let fileManager: FileManager
    let readTransformer: Transformer
    let writeTransformer: Transformer
    
    public init(baseURL: URL, fileManager: FileManager = Foundation.FileManager.default, readTransformer: @escaping Transformer = { $0 }, writeTransformer: @escaping Transformer = { $0 }) {
        self.baseURL = baseURL
        self.fileManager = fileManager
        self.readTransformer = readTransformer
        self.writeTransformer = writeTransformer
    }
    
    func url(for key: Key) -> URL {
        return baseURL.appendingPathComponent(key.rawValue)
    }
}

// MARK: StorageProvider
extension FileSystemStorageProvider: StorageProvider {
    public func deleteValue(for key: Key) throws {
        try fileManager.removeItem(at: url(for: key))
    }
    
    public func value<T: Decodable>(for key: Key) throws -> T? {
        guard let data = fileManager.contents(atPath: url(for: key).path) else {
            return nil
        }
        
        return try defaultDecoded(readTransformer(data))
    }
    
    public func write<T: Encodable>(_ value: T, for key: Key) throws {
        let data = try writeTransformer(defaultEncoded(value))
        let didSaveFile = fileManager.createFile(atPath: url(for: key).path, contents: data, attributes: nil)
        
        if !didSaveFile {
            throw Error.fileWriteFailed
        }
    }
}

// MARK: Error
public extension FileSystemStorageProvider {
    enum Error: Swift.Error {
        case fileWriteFailed
    }
}
