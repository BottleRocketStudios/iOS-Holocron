//
//  Defaults+Container.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    //MARK: StorageOptions Subtype
    public struct StorageOptions: ExpressibleByStringLiteral {
        
        //MARK: Properties
        public let key: String
        
        //MARK: Initializers
        public init(stringLiteral string: String) {
            key = string
        }
    }
}

//MARK: Container
extension UserDefaults: Container {
    
    public func store(_ element: Storable, with options: StorageOptions) throws {
        try set(element.encoded(), forKey: options.key)
    }
    
    public func retrieve<T>(with options: StorageOptions) -> T? where T : Storable {
        guard let data = object(forKey: options.key) as? Data else { return nil }
        return try? T.decoded(from: data)
    }
}
