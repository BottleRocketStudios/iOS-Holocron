//
//  StorageProvider+Default.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/15/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
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
        return try JSONDecoder().decode(Box<T>.self, from: data).element
    }
    
    /// Encodes an object for storage.
    /// - parameter object: The object to encode.
    /// - returns: `Data` containing the encoded representation of the object.
    func defaultEncoded<T: Encodable>(_ object: T) throws -> Data {
        return try JSONEncoder().encode(Box(element: object))
    }
}

// MARK: Subscripting
public extension StorageProvider {
    subscript<T: Codable>(key: Key) -> T? {
        get {
            if let value: T? = try? value(for: key) {
                return value
            }
            
            return nil
        }
        
        set { try? write(newValue, for: key) }
    }
}
