//
//  RequestBuilder.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Alamofire
import Foundation
import Utils

enum RequestBuilderError: Error {
    case urlInvalid
}

enum RequestBuilder: URLRequestConvertible {
    case v3FetchPopularMovies(PopularMovieParams)
    case v3FetchMovieConfiguration

    var endPoint: String {
        return APIConstant.movieEndPoint
    }

    enum Version: String {
        case v3 = "3"

        func path(_ path: String) -> String {
            return rawValue + "/" + path
        }
    }

    var path: String {
        switch self {
        case .v3FetchPopularMovies:
            return Version.v3.path("movie/popular")
        case .v3FetchMovieConfiguration:
            return Version.v3.path("configuration")
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var method: HTTPMethod {
        switch self {
        case .v3FetchPopularMovies:
            return .get
        case .v3FetchMovieConfiguration:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .v3FetchPopularMovies(param):
            return param.toDictionary()
        default: return nil
        }
    }

    var body: Parameters? {
        switch self {
        default: return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let absolutePath = endPoint + "/" + path
        guard let url = URL(string: absolutePath) else {
            throw RequestBuilderError.urlInvalid
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        var params = parameters ?? [:]
        params["api_key"] = APIConstant.movieAPIKey
        request.encode(with: params)
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        request.timeoutInterval = 30.0
        return request
    }
}
