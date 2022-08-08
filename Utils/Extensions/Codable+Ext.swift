//
//  Codable+Ext.swift
//  Utils
//
//  Created by hungnm98 on 27/07/2022.
//

import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let object = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }
        return object
    }
}
