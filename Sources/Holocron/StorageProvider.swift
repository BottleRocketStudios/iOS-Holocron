//
//  StorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

/// An interface for a simple key value store.
public protocol StorageProvider {
    /// Deletes the value associated with the provided key.
    /// - parameter key: The key whose value should be deleted.
    func deleteValue(for key: String) throws
    
    /// Retrieves the value associated for a specific key.
    /// - parameter key: The key whose value to retrieve.
    /// - note: This function should return `nil` if the data found in the key value store cannot be converted to type T.
    func value<T: Decodable>(for key: String) throws -> T?
    
    /// Writes a value for a specific key.
    /// - parameter value: The value to store.
    /// - parameter key: The key to associate with `value`.
    func write<T: Encodable>(_ value: T, for key: String) throws
}

/// An interface for an asynchronous, failable key value store.
/// This interface is a superset of that for a simple key value store, as described in `StorageProvider`.
public protocol AsyncStorageProvider: StorageProvider {
    /// Asynchronously deletes the value associated with the provided key.
    /// - parameter key: The key whose value should be deleted.
    /// - returns: A `Result` describing the completion of the operation.
    func deleteValue(for key: String) -> Result<Void, Error>
    
    /// Asynchronoushly retrieves the value associated for a specific key.
    /// - parameter key: The key whose value to retrieve.
    /// - returns: A `Result` describing the completion of the operation.
    /// - note: This function will complete with a `nil` value if the data found in the key value store cannot be converted to type T.
    func value<T: Decodable>(for key: String) -> Result<T, Error>
    
    /// Asynchronously writes a value for a specific key.
    /// - parameter value: The value to store.
    /// - parameter key: The key to associate with `value`.
    /// - returns: A `Result` describing the completion of the operation.
    func write(_ value: Encodable, for key: String) -> Result<Void, Error>
}
