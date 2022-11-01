//
//  RPopularMoviesParam.swift
//  RealmPlatform
//
//  Created by user on 01/11/2022.
//

import Foundation

public struct RPopularMoviesParam: Encodable {
    public let page: Int
    public let limit: Int

    public init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }
}
