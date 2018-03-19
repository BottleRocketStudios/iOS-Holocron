//
//  FileContainer.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public struct FileContainer: Container {
    
    //MARK: Error Subtype
    public enum Error: Swift.Error {
        case noParentDirectory
    }

    //MARK: Options Subtype
    public struct StorageOptions {
        
        //MARK: URL
        let url: URL
        let overwrite: Bool
        let fileProtection: FileProtectionType?
        
        //MARK: Initializers
        public init(url: URL, overwrite: Bool = true, fileProtection: FileProtectionType? = nil) {
            self.url = url
            self.overwrite = overwrite
            self.fileProtection = fileProtection
        }
    }
    
    //MARK: Properties
    private let fileManager = FileManager.default
    public let fileProtection: FileProtectionType
    
    //MARK: Initializers
    public init(fileProtectionType: FileProtectionType = .completeUntilFirstUserAuthentication) {
        fileProtection = fileProtectionType
    }
    
    //MARK: Container
    public func store(_ element: Codable, with options: StorageOptions) throws {
        try archive(data: element.defaultlyEncoded(), to: options.url, overwrite: options.overwrite, fileProtection: options.fileProtection)
    }
    
    public func retrieve<T: Codable>(with options: StorageOptions) throws -> T? {
        guard let data = try archivedData(at: options.url) else { return nil }
        return try data.defaultlyDecoded()
    }
    
    public func removeElement(with options: FileContainer.StorageOptions) {
        try? fileManager.removeItem(at: options.url)
    }
    
    //MARK: Helper
    public func archive(data: Data, to url: URL, overwrite: Bool, fileProtection: FileProtectionType?) throws {
        func write(_ data: Data, to url: URL, fileProtection: FileProtectionType?) {
            let attributes = [FileAttributeKey.protectionKey : fileProtection ?? self.fileProtection]
            fileManager.createFile(atPath: url.path, contents: data, attributes: attributes)
        }
        
        if fileManager.fileExists(atPath: url.path) {
            guard overwrite else { return /* File exists, and we don't overwrite */ }
            try fileManager.removeItem(at: url)
        }
        
        var isDirectory: ObjCBool = false
        let containerDirectoryPath = NSString(string: url.path).deletingLastPathComponent
        let containerExists = fileManager.fileExists(atPath: containerDirectoryPath, isDirectory: &isDirectory)
        
        if containerExists {
            guard isDirectory.boolValue else { throw Error.noParentDirectory }
            write(data, to: url, fileProtection: fileProtection)
        } else {
            try fileManager.createDirectory(atPath: containerDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            write(data, to: url, fileProtection: fileProtection)
        }
    }
    
    public func archivedData(at url: URL) throws -> Data? {
        return try Data(contentsOf: url)
    }
}
