//
//  PopularMoviesParam.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 27/07/2022.
//

import Foundation

public struct PopularMovieParams: Codable {
    public let page: Int

    public init(page: Int) {
        self.page = page
    }
}
