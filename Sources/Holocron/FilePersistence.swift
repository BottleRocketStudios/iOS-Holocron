//
//  FileWriter.swift
//  Holocron
//
//  
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

// Testing Danger...

import Foundation

public struct FileStore {
    
    public let fileName: String
    public let createIntermediateDirectories: Bool
    public let protectionType: FileProtectionType?
    public let writeDataTransformBlock: ((Data) -> (Data))?
    public let readDataTransformBlock: ((Data) -> (Data))?
    
    //MARK: Initializer
    /// Initializes the file store
    ///
    /// - Parameters:
    ///   - fileName: the name of the file
    ///   - createIntermediateDirectories: A bool to specify if intermediate directories need to be created, defaults to true
    ///   - protectionType: An optional File Protection level, default is nil
    ///   - writeDataTransformBlock: A block used to transform the data before being written but after encoding. Useful for a custom encryption scheme.
    ///   - readDataTransformBlock: A block used to transform the data after being read, but before decoding. Useful for a custom decryption scheme.
    public init(fileName: String, createIntermediateDirectories: Bool = true, protectionType: FileProtectionType? = nil, writeDataTransformBlock: ((Data) -> (Data))? = nil, readDataTransformBlock: ((Data) -> (Data))? = nil) {
        self.fileName = fileName
        self.createIntermediateDirectories = createIntermediateDirectories
        self.protectionType = protectionType
        self.writeDataTransformBlock = writeDataTransformBlock
        self.readDataTransformBlock = readDataTransformBlock
    }
}

public struct FilePersistence {
    private let fileManager = FileManager()
    fileprivate let directory: URL
    
   //MARK: Initializer
    /// Initializes the File Persistence
    ///
    /// - Parameter directory: The directory where the file needs to be written to, defaults to the documents directory
    public init(directory: URL? = nil) {
        self.directory = directory ?? FileManager.documentsDirectoryURL
    }
}

//MARK: Storage Container Protocol Conformance

extension FilePersistence: StorageContainer {
    
    public func write<T: Codable>(object: T, for store: FileStore, completion: WriteCompletion<T>?) {
        let writeURL = directory.appendingPathComponent(store.fileName, isDirectory: false)
        let directoryString = writeURL.deletingLastPathComponent().path
        do {
            if !fileManager.fileExists(atPath: directoryString) {
                try fileManager.createDirectory(at: writeURL.deletingLastPathComponent(), withIntermediateDirectories: store.createIntermediateDirectories, attributes: nil)
            }
            let data = try encodeWritableObject(object)
            
            let transformedData = store.writeDataTransformBlock?(data) ?? data
        
            try transformedData.write(to: writeURL)
            
            completion?(.success(object))
        } catch {
            completion?(.failure(StorageError.write(error: error)))
        }
    }
    
    public func retrieve<T: Codable>(object: FileStore, completion: @escaping ReadCompletion<T>) {
        let url = directory.appendingPathComponent(object.fileName)
        
        guard let data = fileManager.contents(atPath: url.path) else {
            completion(.failure(StorageError.notFound(file: url.path)))
            return
        }
        do {
            let decrypted = object.readDataTransformBlock?(data) ?? data
            
            let decoded: T = try decodeReadableObject(from: decrypted)
            
            completion(.success(decoded))
        } catch {
            completion(.failure(StorageError.retrieve(error: error)))
        }
    }
    
    public func removeObject(for store: FileStore, completion: RemoveCompletion? = nil) {
        let pathURL = directory.appendingPathComponent(store.fileName)
        do {
            try fileManager.removeItem(atPath: pathURL.path)
            
            completion?(.success(true))
        } catch {
            completion?(.failure(StorageError.remove(error: error)))
        }
    }
}

extension FileManager {
    static var documentsDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
