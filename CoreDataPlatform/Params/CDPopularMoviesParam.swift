//
//  CDPopularMoviesParam.swift
//  CoreDataPlatform
//
//  Created by Nguyen Manh Hung on 19/08/2022.
//

import Foundation

public struct CDPopularMoviesParam: Encodable {
    public let page: Int
    public let limit: Int

    public init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }
}
