//
//  Movie.swift
//  Domain
//
//  Created by hungnm98 on 21/06/2022.
//

import Foundation

public struct Movie: Codable {
    public init(adult: Bool?, backdropPath: String?, genreIds: [Int]?, id: Int?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?, isFavorite: Bool?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isFavorite = isFavorite
    }

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
    private var isFavorite: Bool?

    public func getIsFavorite() -> Bool? {
        return isFavorite
    }

    public mutating func setFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
