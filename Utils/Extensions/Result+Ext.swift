//
//  Result+Ext.swift
//  Utils
//
//  Created by hungnm98 on 08/08/2022.
//

import Foundation

public extension Result {
    var data: Success? {
        switch self {
        case let .success(success):
            return success
        case .failure:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .success:
            return nil
        case let .failure(failure):
            return failure
        }
    }

    func to<T>(tranform: (Success) -> T) -> Result<T, Failure> {
        switch self {
        case let .success(success):
            return Result<T, Failure>.success(tranform(success))
        case let .failure(failure):
            return Result<T, Failure>.failure(failure)
        }
    }
}
