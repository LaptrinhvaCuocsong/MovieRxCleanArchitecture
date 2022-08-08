//
//  Movies.swift
//  Domain
//
//  Created by hungnm98 on 21/06/2022.
//

import Foundation

public struct Movies: Codable {
    public init(page: Int?, results: [Movie]?, totalPages: Int?, totalResults: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }

    public let page: Int?
    public let results: [Movie]?
    public let totalPages: Int?
    public let totalResults: Int?
}
