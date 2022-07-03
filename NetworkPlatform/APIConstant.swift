//
//  APIConstants.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Foundation

struct APIConstant {
    static let apiErrorMessageCommon: String = "Request error\n Please try again!"
    
    static var movieAPIKey: String {
        return (Bundle.main.infoDictionary?["MOVIE_API_KEY"] as? String) ?? ""
    }

    static var movieEndPoint: String {
        return (Bundle.main.infoDictionary?["MOVIE_DB_ENDPOINT"] as? String) ?? ""
    }
}
