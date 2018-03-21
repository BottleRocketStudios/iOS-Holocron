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
    
    //MARK: Storage
    public func store(_ element: Int, with options: StorageOptions)  {
        set(element, forKey: options.key)
    }
    
    public func store(_ element: Double, with options: StorageOptions)  {
        set(element, forKey: options.key)
    }
    
    public func store(_ element: Float, with options: StorageOptions)  {
        set(element, forKey: options.key)
    }
    
    public func store(_ element: String, with options: StorageOptions)  {
        set(element, forKey: options.key)
    }
    
    public func store(_ element: URL, with options: StorageOptions)  {
        set(element, forKey: options.key)
    }
    
    public func store(_ element: Bool, with options: StorageOptions)  {
        set(element, forKey: options.key)
    }
    
    public func store(_ element: Codable, with options: StorageOptions) throws {
        try set(element.defaultlyEncoded(), forKey: options.key)
    }
    
    //MARK: Retrieval
    public func retrieve(with options: StorageOptions) -> Int? {
        return integer(forKey: options.key)
    }
    
    public func retrieve(with options: StorageOptions) -> Double? {
        return double(forKey: options.key)
    }
    
    public func retrieve(with options: StorageOptions) -> Float? {
        return float(forKey: options.key)
    }
    
    public func retrieve(with options: StorageOptions) -> String? {
        return string(forKey: options.key)
    }
    
    public func retrieve(with options: StorageOptions) -> URL? {
        return url(forKey: options.key)
    }
    
    public func retrieve(with options: StorageOptions) -> Bool? {
        return bool(forKey: options.key)
    }
    
    public func retrieve<T: Codable>(with options: StorageOptions) throws -> T? {
        guard let data = object(forKey: options.key) as? Data else { return nil }
        return try data.defaultlyDecoded()
    }
    
    public func removeElement(with options: UserDefaults.StorageOptions) {
        removeObject(forKey: options.key)
    }
}
