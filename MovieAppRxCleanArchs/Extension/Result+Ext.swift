//
//  Result+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 03/07/2022.
//

import Foundation

extension Result {
    var data: Success? {
        switch self {
        case let .success(success):
            return success
        case .failure:
            return nil
        }
    }

    var error: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(failure):
            return failure
        }
    }
}
