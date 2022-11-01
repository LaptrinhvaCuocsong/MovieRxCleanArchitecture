//
//  RMovieConfiguration+Ext.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import Domain

extension RMovieConfiguration: Persistable {
    var uid: String {
        return id
    }
    
    func asDomain() -> MovieConfiguration {
        return MovieConfiguration(
            images: MovieConfiguration.Images(
                baseUrl: images?.baseUrl,
                secureBaseUrl: images?.secureBaseUrl,
                backdropSizes: images?.backdropSizes.toList(),
                logoSizes: images?.logoSizes.toList(),
                posterSizes: images?.posterSizes.toList(),
                profileSizes: images?.profileSizes.toList(),
                stillSizes: images?.stillSizes.toList()))
    }
}

extension MovieConfiguration: RealmRepresentableType {
    var uid: String {
        return String(describing: MovieConfiguration.self)
    }
    
    func createNewRealmModel() -> RMovieConfiguration {
        return RMovieConfiguration(id: uid, movieConfig: self)
    }
    
    func update(realmModel: RMovieConfiguration) {
        realmModel.images = RImageMovieConfiguration(images: images)
    }
}
