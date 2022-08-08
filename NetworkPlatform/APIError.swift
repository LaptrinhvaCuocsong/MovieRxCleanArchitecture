//
//  APIError.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Foundation

public enum APIError: Error {
    case decodingError
    case httpError(Int, String)
    case unknown(String)
    case noInternet
    case cancel
    
    public var description: String {
        switch self {
        case .decodingError:
            return "Error format JSON"
        case let .httpError(_, value):
            return value
        case let .unknown(value):
            return value
        case .noInternet:
            return "No internet"
        case .cancel:
            return "Request is cancelled"
        }
    }
}
