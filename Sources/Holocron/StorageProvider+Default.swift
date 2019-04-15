//
//  StorageProvider+Default.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/15/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

// MARK: Backwards Compatibility

/// Used to maintain compatibility with the original version of Holocron, which encoded objects using a Box.
/// This version encodes objects without a container to avoid library lock-in, but it knows how to decode objects that were encoded in a Box.
struct Box<T> {
    let element: T
}

extension Box: Decodable where T: Decodable { }
extension Box: Encodable where T: Encodable { }

extension StorageProvider {
    /// Attempts to decode an object that was encoded using `defaultEncoded`.
    /// This function will first attempt to decode the object into a `Box`, and then try to decode a "naked" object.
    /// If both fail, an error will be thrown with the cause of failure.
    /// - parameter data: The data to decode.
    /// - returns: A decoded object.
    func defaultDecoded<T: Decodable>(_ data: Data) throws -> T {
        do {
            let box = try JSONDecoder().decode(Box<T>.self, from: data)
            return box.element
        } catch {
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
    
    /// Encodes an object for storage.
    func defaultEncoded<T: Encodable>(_ object: T) throws -> Data {
        return try JSONEncoder().encode(object)
    }
}

// MARK: Subscripting
public extension StorageProvider {
    // TODO: Add this
}
