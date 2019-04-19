//
//  FileSystemStorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/15/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

/*
 TODO: Add support for:
 * createIntermediateDirectories
 * protectionType
 * read / write transformations
 */

public extension StorageProvider {
    typealias FileSystem = FileSystemStorageProvider
}

public struct FileSystemStorageProvider {
    let baseURL: URL
    
    func url(for key: String) -> URL {
        return baseURL.appendingPathComponent(key)
    }
}

// MARK: StorageProvider
extension FileSystemStorageProvider: StorageProvider {
    public func deleteValue(for key: String) throws {
        try FileManager.default.removeItem(at: url(for: key))
    }
    
    public func value<T>(for key: String) throws -> T? where T : Decodable {
        guard let data = FileManager.default.contents(atPath: url(for: key).path) else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    public func write<T>(_ value: T, for key: String) throws where T : Encodable {
        try defaultEncoded(value).write(to: url(for: key))
    }
}
