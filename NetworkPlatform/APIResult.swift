//
//  APIResult.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Foundation

enum APIResult<T> {
    typealias Element = T

    case success(T)
    case failure(APIError)

    public var data: T? {
        switch self {
        case let .success(data):
            return data
        case .failure:
            return nil
        }
    }

    public var error: APIError? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
}

extension APIResult {
    func mapToResult() -> Result<APIResult.Element, Error> {
        switch self {
        case let .success(data):
            return Result.success(data)
        case let .failure(error):
            return Result.failure(error)
        }
    }
}
