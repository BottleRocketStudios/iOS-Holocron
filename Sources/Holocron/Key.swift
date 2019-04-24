//
//  Key.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/24/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

public struct Key: Hashable, RawRepresentable, ExpressibleByStringLiteral {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: String) {
        self.rawValue = value
    }
}
