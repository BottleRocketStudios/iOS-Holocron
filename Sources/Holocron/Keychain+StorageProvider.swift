//
//  Keychain+StorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import KeychainAccess

public extension StorageProvider {
    typealias Keychain = KeychainAccess.Keychain
}

extension Keychain: StorageProvider {
    public func deleteValue(for key: String) throws {
        try remove(key)
    }
    
    public func value<T>(for key: String) throws -> T? where T : Decodable {
        guard let data = try getData(key) else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    public func write<T>(_ value: T, for key: String) throws where T : Encodable {
        try set(defaultEncoded(value), key: key)
    }
}