//
//  Storable.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public protocol Storable {
    
    func encoded() throws -> Data
    static func decoded(from data: Data) throws -> Self
}
