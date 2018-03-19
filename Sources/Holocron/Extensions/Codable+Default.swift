//
//  Codable+Default.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

extension Data {
    func defaultlyDecoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}

extension Encodable {
    func defaultlyEncoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
