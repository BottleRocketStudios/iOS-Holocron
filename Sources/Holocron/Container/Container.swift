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
    func retrieve<T: Storable>(with options: Options) -> T?
}
