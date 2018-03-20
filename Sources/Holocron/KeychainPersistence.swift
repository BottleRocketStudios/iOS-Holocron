//  KeychainPersistence.swift
//  Data Persistence
//
//  
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

import Foundation
import KeychainAccess
import Result

public struct KeychainStore: ExpressibleByStringLiteral {
    
    /// A unique identifier for setting up the keychain
    public let key: String
    
    //MARK: Initializers
    /// Initializes the keychain store
    ///
    /// - Parameter key: Unique string to setup the store
    public init(key: String) {
        self.key = key
    }
    
    public init(stringLiteral value: StaticString) {
        self.init(key: "\(value)")
    }
}

public struct KeychainPersistence {
    private let keychain: Keychain
    
    //MARK: Initializer
    
    /// Initializes the KeychainPersistence
    ///
    /// - Parameter keychainServiceName: Unique string to setup the persistence
    public init(keychainServiceName: String) {
        keychain = Keychain(service: keychainServiceName)
    }
}

//MARK: Storage Container Protocol Conformance

extension KeychainPersistence: SynchronousStorageContainer {
    
    public func write<T: Codable>(object: T, for store: KeychainStore) throws {
        // encode data and will throw serialization error if failed
        let data = try encodeWritableObject(object)
        keychain[data: store.key] = data
    }
    
    public func write<T: Codable>(object: T, for store: KeychainStore, completion: WriteCompletion<T>?) {
        do {
            try write(object: object, for: store)
            completion?(.success(object))
        } catch {
            completion?(.failure(StorageError.write(error: error)))
        }
    }
    
    public func retrieve<T: Codable>(object: KeychainStore) throws -> T {
        guard let data = keychain[data: object.key] else {
            throw StorageError.notFound(file: object.key)
        }
        // decode data and will throw deserialization error if failed
        return try decodeReadableObject(from : data)
    }
    
    public func retrieve<T: Codable>(object: KeychainStore, completion: @escaping ReadCompletion<T>) {
        do {
            let retrievable: T = try retrieve(object: object)
            completion(.success(retrievable))
        } catch {
            completion(.failure(StorageError.retrieve(error: error)))
        }
    }
    
    public func removeObject(for store: KeychainStore) throws {
        do {
            try keychain.remove(store.key)
        } catch {
            throw StorageError.remove(error: error)
        }
    }
    
    public func removeObject(for store: KeychainStore, completion: RemoveCompletion?) {
        do {
            try removeObject(for: store)
            completion?(.success(true))
        } catch {
            completion?(.failure(StorageError.remove(error: error)))
        }
    }
}
