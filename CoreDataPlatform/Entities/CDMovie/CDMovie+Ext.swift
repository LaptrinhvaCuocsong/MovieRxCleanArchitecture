//
//  CDMovie+Ext.swift
//  CoreDataPlatform
//
//  Created by Nguyen Manh Hung on 18/08/2022.
//

import CoreData
import Domain
import Foundation
import QueryKit
import RxSwift

extension CDMovie {
    static var uid: Attribute<String> { return Attribute("uid") }
    static var adult: Attribute<NSNumber> { return Attribute("adult") }
    static var backdropPath: Attribute<String> { return Attribute("backdropPath") }
    static var genreIds: Attribute<[NSNumber]> { return Attribute("genreIds") }
    static var originalLanguage: Attribute<String> { return Attribute("originalLanguage") }
    static var originalTitle: Attribute<String> { return Attribute("originalTitle") }
    static var overview: Attribute<String> { return Attribute("overview") }
    static var popularity: Attribute<NSNumber> { return Attribute("popularity") }
    static var posterPath: Attribute<String> { return Attribute("posterPath") }
    static var releaseDate: Attribute<String> { return Attribute("releaseDate") }
    static var title: Attribute<String> { return Attribute("title") }
    static var video: Attribute<NSNumber> { return Attribute("video") }
    static var voteAverage: Attribute<NSNumber> { return Attribute("voteAverage") }
    static var voteCount: Attribute<NSNumber> { return Attribute("voteCount") }
}

extension CDMovie: DomainConvertibleType {
    func asDomain() -> Movie {
        return Movie(adult: adult?.boolValue,
                     backdropPath: backdropPath,
                     genreIds: genreIds?.map({ $0.intValue }),
                     id: Int(uid ?? ""),
                     originalLanguage: originalLanguage,
                     originalTitle: originalTitle,
                     overview: overview,
                     popularity: popularity?.doubleValue,
                     posterPath: posterPath,
                     releaseDate: releaseDate,
                     title: title,
                     video: video?.boolValue,
                     voteAverage: voteAverage?.doubleValue,
                     voteCount: voteCount?.intValue)
    }
}

extension CDMovie: Persistable {
    static var entityName: String {
        return "CDMovie"
    }
}

extension Movie: CoreDataRepresentable {
    typealias CoreDataType = CDMovie

    var uid: String {
        return String(id ?? -1)
    }

    func update(entity: CDMovie) {
        entity.uid = uid
        entity.adult = NSNumber(value: adult ?? false)
        entity.backdropPath = backdropPath
        entity.genreIds = genreIds?.map({ NSNumber(value: $0) })
        entity.originalLanguage = originalLanguage
        entity.originalTitle = originalTitle
        entity.overview = overview
        entity.popularity = NSNumber(value: popularity ?? 0)
        entity.posterPath = posterPath
        entity.releaseDate = releaseDate
        entity.title = title
        entity.video = NSNumber(value: video ?? false)
        entity.voteAverage = NSNumber(value: voteAverage ?? 0)
        entity.voteCount = NSNumber(value: voteCount ?? 0)
        if entity.createAt == nil {
            entity.createAt = Date()
        }
        entity.isFavorite = NSNumber(value: self.getIsFavorite())
    }
}
