//
//  CDImageMovieConfiguration+Ext.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 04/08/2022.
//

import CoreData
import Domain
import Foundation
import QueryKit
import RxSwift

extension CDImageMovieConfiguration {
    static var uid: Attribute<String> { return Attribute("uid") }
    static var baseURL: Attribute<String> { return Attribute("baseURL") }
    static var secureBaseURL: Attribute<String> { return Attribute("secureBaseURL") }
    static var backdropSizes: Attribute<[String]> { return Attribute("backdropSizes") }
    static var logoSizes: Attribute<[String]> { return Attribute("logoSizes") }
    static var posterSizes: Attribute<[String]> { return Attribute("posterSizes") }
    static var profileSizes: Attribute<[String]> { return Attribute("profileSizes") }
    static var stillSizes: Attribute<[String]> { return Attribute("stillSizes") }
}

extension CDImageMovieConfiguration: DomainConvertibleType {
    func asDomain() -> MovieConfiguration.Images {
        return MovieConfiguration.Images(baseURL: baseURL,
                                         secureBaseURL: secureBaseURL,
                                         backdropSizes: backdropSizes,
                                         logoSizes: logoSizes,
                                         posterSizes: posterSizes,
                                         profileSizes: posterSizes,
                                         stillSizes: stillSizes)
    }
}

extension CDImageMovieConfiguration: Persistable {
    static var entityName: String {
        return "CDImageMovieConfiguration"
    }
}

extension MovieConfiguration.Images: CoreDataRepresentable {
    typealias CoreDataType = CDImageMovieConfiguration

    var uid: String {
        return ""
    }

    func update(entity: CDImageMovieConfiguration) {
        entity.baseURL = baseURL
        entity.secureBaseURL = secureBaseURL
        entity.backdropSizes = backdropSizes
        entity.logoSizes = logoSizes
        entity.posterSizes = posterSizes
        entity.profileSizes = profileSizes
        entity.stillSizes = stillSizes
    }
}
