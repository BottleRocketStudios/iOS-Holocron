//
//  FileContainer.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public struct FileContainer: Container {

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
    public func store(_ element: Storable, with options: StorageOptions) throws {
        try archive(data: element.encoded(), to: options.url, overwrite: options.overwrite, fileProtection: options.fileProtection)
    }
    
    public func retrieve<T>(with options: StorageOptions) -> T? where T : Storable {
        guard let data = archivedData(at: options.url) else { return nil }
        return try? T.decoded(from: data)
    }
    
    //MARK: Helper
    public func archive(data: Data, to url: URL, overwrite: Bool, fileProtection: FileProtectionType?) throws {
        if fileManager.fileExists(atPath: url.path) {
            guard overwrite else { return /* File exists, and we don't overwrite */ }
            try fileManager.removeItem(at: url)
        }
        
        //let containerDirectoryPath = NSString(string: url.path).deletingLastPathComponent
        //try fileManager.createDirectory(atPath: containerDirectoryPath, withIntermediateDirectories: false, attributes: nil)
    
        let attributes = [FileAttributeKey.protectionKey : fileProtection ?? self.fileProtection]
        fileManager.createFile(atPath: url.path, contents: data, attributes: attributes)
    }
    
    public func archivedData(at url: URL) -> Data? {
        return try? Data(contentsOf: url)
    }
}
