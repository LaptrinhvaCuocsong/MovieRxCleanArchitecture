//
//  HTTPURLResponse+Ext.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 05/07/2022.
//

import Foundation

extension HTTPURLResponse {
    func log(data: Data?) {
        let status = 200 ... 299 ~= statusCode
        print("---------------RESPONSE--------------")
        print(status ? "😍 SUCCESS" : "😭 ERROR")
        print("✎ RESPONSE URL: \(String(describing: url?.absoluteString ?? ""))")
        print("✎ Status Code: \(statusCode)")
        print("✎ Response Header:")
        print(headers)
        print("✎ Response Data:\n")
        print(data?.prettyPrintedJSONString ?? "")
        print("------------------------------------")
    }
}
