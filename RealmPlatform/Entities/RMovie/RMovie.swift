//
//  RMovie.swift
//  RealmPlatform
//
//  Created by user on 01/11/2022.
//

import Foundation
import RealmSwift
import Domain
import Utils

class RMovie: Object {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var adult: Bool?
    @Persisted var backdropPath: String?
    @Persisted var genreIds = List<Int>()
    @Persisted var originalLanguage: String?
    @Persisted var originalTitle: String?
    @Persisted var overview: String?
    @Persisted var popularity: Double?
    @Persisted var posterPath: String?
    @Persisted var releaseDate: String?
    @Persisted var title: String?
    @Persisted var video: Bool?
    @Persisted var voteAverage: Double?
    @Persisted var voteCount: Int?
    @Persisted var createAt = Date()
    @Persisted var isFavorite: Bool?
    
    convenience init(movie: Movie) {
        self.init(value: movie.toDictionary())
    }
}
