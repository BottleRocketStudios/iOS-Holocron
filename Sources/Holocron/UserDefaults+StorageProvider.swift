//
//  UserDefaults+StorageProvider.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public extension StorageProvider {
    typealias UserDefaults = Foundation.UserDefaults
}

extension UserDefaults: StorageProvider {
    public func deleteValue(for key: String) {
        removeObject(forKey: key)
    }
    
    public func value<T: Decodable>(for key: String) throws -> T? {
        guard let data = data(forKey: key) else {
            return nil
        }
        
        return try defaultDecoded(data)
    }
    
    public func write<T: Encodable>(_ value: T, for key: String) throws {
        try set(defaultEncoded(value), forKey: key)
    }
}
