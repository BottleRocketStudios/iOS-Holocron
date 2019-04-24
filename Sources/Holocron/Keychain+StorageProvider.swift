//
//  Keychain+StorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/10/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import KeychainAccess

public extension StorageProvider {
    typealias Keychain = KeychainAccess.Keychain
}

extension Keychain: StorageProvider {
    public func deleteValue(for key: Key) throws {
        try remove(key.rawValue)
    }
    
    public func value<T: Decodable>(for key: Key) throws -> T?{
        guard let data = try getData(key.rawValue) else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    public func write<T: Encodable>(_ value: T, for key: Key) throws {
        try set(defaultEncoded(value), key: key.rawValue)
    }
}
