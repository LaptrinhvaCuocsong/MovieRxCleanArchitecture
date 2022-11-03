//
//  RMovie+Ext.swift
//  RealmPlatform
//
//  Created by user on 01/11/2022.
//

import Domain
import Foundation
import RealmSwift

extension RMovie: Persistable {
    var uid: String {
        return String(id ?? -1)
    }

    func asDomain() -> Movie {
        return Movie(adult: adult,
                     backdropPath: backdropPath,
                     genreIds: genreIds.toList(),
                     id: id,
                     originalLanguage: originalLanguage,
                     originalTitle: originalTitle,
                     overview: overview,
                     popularity: popularity,
                     posterPath: posterPath,
                     releaseDate: releaseDate,
                     title: title,
                     video: video,
                     voteAverage: voteAverage,
                     voteCount: voteCount,
                     isFavorite: isFavorite)
    }
}

extension Domain.Movie: RealmRepresentableType {
    var uid: String {
        return String(id ?? -1)
    }

    func createNewRealmModel() -> RMovie {
        return RMovie(movie: self)
    }

    func update(realmModel: RMovie) {
        realmModel.adult = adult
        realmModel.backdropPath = backdropPath
        realmModel.genreIds.removeAll()
        realmModel.genreIds.append(objectsIn: genreIds ?? [])
        realmModel.originalLanguage = originalLanguage
        realmModel.originalTitle = originalTitle
        realmModel.overview = overview
        realmModel.popularity = popularity
        realmModel.posterPath = posterPath
        realmModel.releaseDate = releaseDate
        realmModel.title = title
        realmModel.video = video
        realmModel.voteAverage = voteAverage
        realmModel.voteCount = voteCount
        if let isFavorite = getIsFavorite() {
            realmModel.isFavorite = isFavorite
        }
    }
}
