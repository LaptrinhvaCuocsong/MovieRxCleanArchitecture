//
//  Movie.swift
//  Domain
//
//  Created by hungnm98 on 21/06/2022.
//

import Foundation

public struct Movie: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIds: [Int]?
    public let id: Int?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let releaseDate: String? // yyyy-dd-MM
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
}
