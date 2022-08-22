//
//  Movies.swift
//  Domain
//
//  Created by hungnm98 on 21/06/2022.
//

import Foundation

public struct Movies: Codable {
    public init(page: Int?, results: [Movie]?, totalPages: Int?, totalResults: Int?, pageSize: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.pageSize = pageSize
    }

    public let page: Int?
    public let results: [Movie]?
    public let totalPages: Int?
    public let totalResults: Int?
    public let pageSize: Int?

    public var isEndLoadMore: Bool {
        let page = self.page ?? 0
        let count = results?.count ?? 0
        if let totalPages = totalPages {
            return page >= totalPages
        } else if let pageSize = pageSize {
            return count < pageSize
        }
        return false
    }
}
