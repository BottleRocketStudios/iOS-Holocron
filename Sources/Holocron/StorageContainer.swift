//
//  StorageContainer.swift
//  Data Persistence
//
//  
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

import Foundation
import Result


/// Custom Error Handling
/// - notFound: Error thrown when a resource could not be found at the specified location
/// - write: Error thrown when the write fails to any of the persistence stores (UserDefaults/Keychain/FileManager)
/// - retrieve: Error thrown when the data retrieval fails from any of the persistence stores (UserDefaults/Keychain/FileManager)
/// - remove: Error thrown when the data could not be deleted from any of the persistence stores (UserDefaults/Keychain/FileManager)
/// - serialization: Error thrown when the data serialization failed while writing to any of the persistence stores (UserDefaults/Keychain/FileManager)
/// - deserialization: Error thrown when the data serialization failed while reading from any of the persistence stores (UserDefaults/Keychain/FileManager)
public enum StorageError: Error {
    case notFound(file: String)
    case write(error: Error)
    case retrieve(error: Error)
    case remove(error: Error)
    case serialization(error: Error)
    case deserialization(error: Error)
}


/// The generic storage container protocol to which the Userdefaults, Keychain and FileManager conform to
public protocol StorageContainer {
    associatedtype StorageContainerStore
    
    typealias WriteCompletion<T> = (Result<T, StorageError>) -> Void
//
    /// This method writes an object to the appropriate persistence store
    ///
    /// - Parameters:
    ///   - object: the object that needs to be persisted
    ///   - store: Appropriate Persistence store (UserDefaults/Keychain/FileManager)
    ///   - completion: The completion block that gets executed once the write operation is done
    /// - Returns: Void
    func write<T: Codable>(object: T, for store: StorageContainerStore, completion: WriteCompletion<T>?)
    
    typealias ReadCompletion<T> = (Result<T, StorageError>) -> Void
    
    /// This method reads an object from the appropriate persistence store
    ///
    /// - Parameters:
    ///   - object: the object that needs to be persisted
    ///   - completion: The completion block that gets executed once the read operation is done
    /// - Returns: Void
    func retrieve<T: Codable>(object: StorageContainerStore, completion: @escaping ReadCompletion<T>)
    
    typealias RemoveCompletion = (Result<Bool, StorageError>) -> Void
    
    /// This method removes an object from the appropriate persistence store
    ///
    /// - Parameters:
    ///   - store: Appropriate Persistence store (UserDefaults/Keychain/FileManager)
    ///   - completion: The completion block that gets executed once the remove operation is done
    func removeObject(for store: StorageContainerStore, completion: RemoveCompletion?)
}

//
public protocol SynchronousStorageContainer: StorageContainer {
    
    /// This method writes an object to the appropriate persistence store
    ///
    /// - Parameters:
    ///   - object: the object that needs to be persisted
    ///   - store: Appropriate Persistence store (UserDefaults/Keychain/FileManager)
    /// - Returns: Void
    /// - Throws: StorageError with the error information
    
    func write<T: Codable>(object: T, for store: StorageContainerStore) throws
    
    /// This method reads an object from the appropriate persistence store
    ///
    /// - Parameter object: Appropriate Persistence store (UserDefaults/Keychain/FileManager)
    /// - Returns: Void
    /// - Throws: StorageError with the error information
    
    func retrieve<T: Codable>(object: StorageContainerStore) throws -> T
    
    /// This method removes an object from the appropriate persistence store
    ///
    /// - Parameter store: Appropriate Persistence store (UserDefaults/Keychain/FileManager)
    /// - Throws: StorageError with the error information
    func removeObject(for store: StorageContainerStore) throws
}

private struct JSONBox<T: Codable>: Codable {
    let element: T
}

extension StorageContainer {
    func encodeWritableObject<T: Codable>(_ object: T, encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        let box = JSONBox(element: object)
        do {
            return try encoder.encode(box)
        } catch {
            throw StorageError.serialization(error: error)
        }
    }
    
    func decodeReadableObject<T: Codable>(from data: Data, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        do {
            let decodedData = try decoder.decode(JSONBox<T>.self, from: data)
            return decodedData.element
        } catch {
            throw StorageError.deserialization(error: error)
        }
    }
}


