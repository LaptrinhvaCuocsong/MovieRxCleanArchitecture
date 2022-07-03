//
//  URLRequest+Ext.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 22/06/2022.
//

import Alamofire
import Foundation

extension URLRequest {
    var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        return command.joined(separator: " \\\n\t")
    }

    mutating func encode(with parameters: Parameters?) {
        guard let url = self.url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let params = parameters,
              !params.isEmpty else {
            return
        }
        let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + parametersToQuery(params)
        urlComponents.percentEncodedQuery = percentEncodedQuery
        self.url = urlComponents.url
    }

    func parametersToQuery(_ parameters: Parameters) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += URLEncoding.default.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
