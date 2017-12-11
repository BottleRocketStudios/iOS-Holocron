//
//  UserDefaultsPersistence.swift
//  Data Persistence
//
//  
//  Copyright © 2017 Bottle Rocket. All rights reserved.
//

import Foundation
import Result

public struct UserDefaultsStore: ExpressibleByStringLiteral {
    /// A unique identifier for setting up the userDefaults
    
    public let key: String
    
    //MARK: Initializers
    /// Initializes the User defaults store
    ///
    /// - Parameter key: Unique identifier for setting up the store
    public init(key: String) {
        self.key = key
    }
    
    public init(stringLiteral value: StaticString) {
        self.init(key: "\(value)")
    }
}

public struct UserDefaultsPersistence {
    let defaults: UserDefaults
    
    //MARK: Initializer
    /// Initializes the User defaults persistence
    ///
    /// - Parameter defaults: Standard User defaults, however customizable
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}

//MARK: Storage Container Protocol Conformance

extension UserDefaultsPersistence: SynchronousStorageContainer {
    public func write<T: Codable>(object: T, for store: UserDefaultsStore) throws {
        // encode data and will throw serialization error if failed
        let data = try encodeWritableObject(object)
        defaults.set(data, forKey: store.key)
    }
    
    public func write <T: Codable>(object: T, for key: UserDefaultsStore, completion: WriteCompletion<T>?) {
        do {
            try write(object: object, for: key)
             completion?(.success(object))
        } catch {
            completion?(.failure(StorageError.write(error: error)))
        }
    }
    
    public func retrieve<T: Codable>(object: UserDefaultsStore) throws -> T {
        guard let data = defaults.data(forKey: object.key) else {
            throw StorageError.notFound(file: object.key)
        }
        // decode data and will throw deserialization error if failed
        return try decodeReadableObject(from : data)
    }

    public func retrieve<T: Codable>(object: UserDefaultsStore, completion: @escaping ReadCompletion<T>) {
        do {
            let retrievable: T = try retrieve(object: object)
            completion(.success(retrievable))
        } catch {
            completion(.failure(StorageError.retrieve(error: error)))
        }
    }
    
    public func removeObject(for store: UserDefaultsStore, completion: RemoveCompletion?) {
        do {
            try removeObject(for: store)
            completion?(.success(true))
        } catch {
            completion?(.failure(StorageError.remove(error: error)))
        }
    }
    
    public func removeObject(for store: UserDefaultsStore) throws {
        defaults.removeObject(forKey: store.key)
    }
}
