//
//  StorageProvider+Default.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/15/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

// MARK: Box
struct Box<T> {
    let element: T
}

extension Box: Decodable where T: Decodable { }
extension Box: Encodable where T: Encodable { }

// MARK: StorageProvider + Default Coding
private var _defaultDecoder = JSONDecoder()
private var _defaultEncoder = JSONEncoder()

extension StorageProvider {
    public static var defaultDecoder: JSONDecoder {
        get { return _defaultDecoder }
        set { _defaultDecoder = newValue }
    }
    
    public static var defaultEncoder: JSONEncoder {
        get { return _defaultEncoder }
        set { _defaultEncoder = newValue }
    }
    
    /// Attempts to decode an object that was encoded using `defaultEncoded`.
    /// - parameter data: The data to decode.
    /// - returns: A decoded object.
    func defaultDecoded<T: Decodable>(_ data: Data) throws -> T {
        return try _defaultDecoder.decode(Box<T>.self, from: data).element
    }
    
    /// Encodes an object for storage.
    /// - parameter object: The object to encode.
    /// - returns: `Data` containing the encoded representation of the object.
    func defaultEncoded<T: Encodable>(_ object: T) throws -> Data {
        return try _defaultEncoder.encode(Box(element: object))
    }
}

// MARK: StorageProvider + Subscripting
public extension StorageProvider {
    subscript<T: Codable>(key: Key) -> T? {
        get { return (try? value(for: key)).flatMap { $0 }}
        set { try? write(newValue, for: key) }
    }
}
