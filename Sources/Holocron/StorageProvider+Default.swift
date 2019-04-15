//
//  StorageProvider+Default.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/15/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

// MARK: Default Coding
struct Box<T> {
    let element: T
}

extension Box: Decodable where T: Decodable { }
extension Box: Encodable where T: Encodable { }

extension StorageProvider {
    /// Attempts to decode an object that was encoded using `defaultEncoded`.
    /// - parameter data: The data to decode.
    /// - returns: A decoded object.
    func defaultDecoded<T: Decodable>(_ data: Data) throws -> T {
        let box = try JSONDecoder().decode(Box<T>.self, from: data)
        return box.element
    }
    
    /// Encodes an object for storage.
    func defaultEncoded<T: Encodable>(_ object: T) throws -> Data {
        return try JSONEncoder().encode(Box(element: object))
    }
}

// MARK: Subscripting
public extension StorageProvider {
    // TODO: Add this
}
