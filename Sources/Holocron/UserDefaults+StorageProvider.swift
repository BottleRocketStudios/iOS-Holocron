//
//  UserDefaults+StorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/10/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import Foundation

public extension StorageProvider {
    typealias UserDefaults = Foundation.UserDefaults
}

extension UserDefaults: StorageProvider {
    public func deleteValue(for key: Key) {
        removeObject(forKey: key.rawValue)
    }
    
    public func value<T: Decodable>(for key: Key) throws -> T? {
        guard let data = data(forKey: key.rawValue) else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    public func write<T: Encodable>(_ value: T, for key: Key) throws {
        try set(defaultEncoded(value), forKey: key.rawValue)
    }
}
