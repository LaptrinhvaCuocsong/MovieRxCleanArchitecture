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
    
    static func createEmptyObject() -> Self {
        return RMovieConfiguration() as! Self
    }
}

extension MovieConfiguration: RealmRepresentableType {
    var uid: String {
        return String(describing: MovieConfiguration.self)
    }
    
    func update(entity: RMovieConfiguration) {
        guard let images = self.images else {
            return
        }
        entity.id = uid
        let rImage = RImageMovieConfiguration()
        rImage.baseUrl = images.baseUrl
        rImage.secureBaseUrl = images.secureBaseUrl
        rImage.backdropSizes.removeAll()
        rImage.backdropSizes.append(objectsIn: images.backdropSizes ?? [])
        rImage.logoSizes.removeAll()
        rImage.logoSizes.append(objectsIn: images.logoSizes ?? [])
        rImage.posterSizes.removeAll()
        rImage.posterSizes.append(objectsIn: images.posterSizes ?? [])
        rImage.profileSizes.removeAll()
        rImage.profileSizes.append(objectsIn: images.profileSizes ?? [])
        rImage.stillSizes.removeAll()
        rImage.stillSizes.append(objectsIn: images.stillSizes ?? [])
    }
}
