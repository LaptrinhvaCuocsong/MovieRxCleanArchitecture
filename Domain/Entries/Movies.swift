//
//  Movies.swift
//  Domain
//
//  Created by hungnm98 on 21/06/2022.
//

import Foundation

public struct Movies: Codable {
    public let page: Int?
    public let results: [Movie]?
    public let totalPages: Int?
    public let totalResults: Int?
}
