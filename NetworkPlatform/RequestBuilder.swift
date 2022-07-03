//
//  RequestBuilder.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Foundation
import Alamofire

enum RequestBuilderError: Error {
    case urlInvalid
}

enum RequestBuilder: URLRequestConvertible {
    case getPopularMovies
    
    var endPoint: String {
        return APIConstant.movieEndPoint
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "movie/popular"
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopularMovies:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPopularMovies:
            return nil
        }
    }
    
    var body: Parameters? {
        switch self {
        case .getPopularMovies:
            return nil
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
        request.encode(with: parameters)
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        request.timeoutInterval = 30.0
        return request
    }
}
