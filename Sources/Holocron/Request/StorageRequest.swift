//
//  StorageRequest.swift
//  Holocron-iOSExample
//
//  Created by Will McGinty on 3/15/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Result

public protocol StorageRequest {
    /// The model type that this StorageRequest will attempt to transform Data into.
    associatedtype ResponseType
    associatedtype ErrorType: Swift.Error
    
    func decoder(_ data: Data) -> Result<ResponseType, ErrorType>
    func encoder(_ element: ResponseType) -> Result<Data, ErrorType>
}

//struct AnyStorageRequest<T>: StorageRequest {
//
//    private let decoder: (Data) -> Result<ResponseType, ErrorType>
//    private let encoder: (ResponseType) -> Result<Data, ErrorType>
//
//    public init<E: StorageRequest>(_ request: E) where E.ResponseType == T {
//        self.decoder = request.decoder
//        self.encoder = request.encoder
//    }
//}

