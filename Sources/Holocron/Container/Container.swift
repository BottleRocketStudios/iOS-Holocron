//
//  Container.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public protocol Container {
    associatedtype Options
    
    func store(_ element: Storable, with options: Options) throws
    func retrieve<T: Storable>(with options: Options) throws -> T?
    func removeElement(with options: Options)
}

extension Container {
    
    public subscript<T: Storable>(options: Options) -> T? {
        get {
            let element: T?? = try? retrieve(with: options)
            return element ?? nil
        }
        set(newValue) {
            guard let newValue = newValue else { removeElement(with: options); return }
            try? store(newValue, with: options)
        }
    }
}
