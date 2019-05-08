//
//  FileManager.swift
//  Holocron-iOS
//
//  Created by Pranjal Satija on 4/29/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import Foundation

public protocol FileManager {
    func contents(atPath path: String) -> Data?
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool
    func removeItem(at URL: URL) throws
}

extension Foundation.FileManager: FileManager { }
