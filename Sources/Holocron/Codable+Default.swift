//
//  Codable+Default.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct Box<T: Codable>: Codable {
    let element: T
}

extension Data {
    func defaultlyDecoded<T: Codable>() throws -> T {
        return try JSONDecoder().decode(Box<T>.self, from: self).element
    }
}

extension Encodable where Self: Decodable {
    func defaultlyEncoded() throws -> Data {
        return try JSONEncoder().encode(Box(element: self))
    }
}
