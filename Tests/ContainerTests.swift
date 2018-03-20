//
//  ContainerTests.swift
//  Holocron-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Holocron

class ContainerTests: XCTestCase {
    
    var container: UserDefaults = UserDefaults.standard
    
    struct Stored: Codable, Equatable {
        let id: Int
        let title: String
        
        static func ==(lhs: Stored, rhs: Stored) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
    
//    func testContainer_subscriptRetrieval() {
//        let value = Stored(id: 1, title: "title")
//        container["testKey"] = value
//        XCTAssertEqual(value, container["testKey"])
//    }
//    
//    func testContainer_failedSubscriptRetrieval() {
//        let x: Stored? = container["testKey2"]
//        XCTAssertNil(x)
//    }
//    
//    func testContainer_subscriptingNilRemovesObject() {
//        let value = Stored(id: 1, title: "title")
//        container["testKey"] = value
//        XCTAssertEqual(value, container["testKey"])
//        
//        container["testKey"] = Optional<Stored>.none
//        let x: Stored? = container["testKey"]
//        XCTAssertNil(x)
//    }
}
