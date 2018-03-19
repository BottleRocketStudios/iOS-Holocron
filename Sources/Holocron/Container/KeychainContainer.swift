//
//  KeychainContainer.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import KeychainAccess

public struct KeychainContainer: Container {
    
    //MARK: Options Subtype
    public struct StorageOptions: ExpressibleByStringLiteral {
        
        public let key: String
        
        //MARK: Initializers
        public init(stringLiteral string: String) {
            key = string
        }
    }
    
    private let keychain: Keychain
    
    //MARK: Initializers
    public init(serviceName: String) {
        self.init(keychain: Keychain(service: serviceName))
    }
    
    public init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    //MARK: Container
    public func store(_ element: String?, with options: StorageOptions) throws {
        guard let element = element else { return }
        return try keychain.set(element, key: options.key)
    }
    
    public func store(_ element: Codable, with options: StorageOptions) throws {
        return try keychain.set(element.defaultlyEncoded(), key: options.key)
    }
    
    public func retrieve(with options: StorageOptions) throws -> String? {
        return keychain[string: options.key]
    }
    
    public func retrieve<T: Codable>(with options: StorageOptions) throws -> T? {
        guard let data = keychain[data: options.key] else { return nil }
        return try data.defaultlyDecoded()
    }
    
    public func removeElement(with options: KeychainContainer.StorageOptions) {
        try? keychain.remove(options.key)
    }
}
