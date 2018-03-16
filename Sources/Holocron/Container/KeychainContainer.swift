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
    public init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    //MARK: Container
    public func store(_ element: Storable, with options: StorageOptions) throws {
        return try keychain.set(element.encoded(), key: options.key)
    }
    
    public func retrieve<T>(with options: StorageOptions) -> T? where T : Storable {
        guard let data = keychain[data: options.key] else { return nil }
        return try? T.decoded(from: data)
    }
}
