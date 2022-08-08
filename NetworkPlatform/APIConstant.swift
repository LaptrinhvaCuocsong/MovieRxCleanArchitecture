//
//  APIConstants.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Foundation

let mainBundle = Bundle(identifier: "com.hungnm.NetworkPlatform")

struct APIConstant {
    static let apiErrorMessageCommon: String = "Request error\n Please try again!"
    
    static var movieAPIKey: String {
        return mainBundle?.infoDictionary?["MOVIE_API_KEY"] as? String ?? ""
    }

    static var movieEndPoint: String {
        let val = mainBundle?.infoDictionary?["MOVIE_DB_ENDPOINT"] as? String
        return (val ?? "").replacingOccurrences(of: "\\", with: "")
    }
}
