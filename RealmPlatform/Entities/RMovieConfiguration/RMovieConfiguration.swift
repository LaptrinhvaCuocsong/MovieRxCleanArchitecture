//
//  RMovieConfiguration.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RealmSwift
import Domain

class RMovieConfiguration: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var images: RImageMovieConfiguration?
    
    convenience init(id: String, movieConfig: MovieConfiguration) {
        self.init(value: ["id": id, "images": RImageMovieConfiguration(images: movieConfig.images)])
    }
}

class RImageMovieConfiguration: EmbeddedObject {
    @Persisted var baseUrl: String?
    @Persisted var secureBaseUrl: String?
    @Persisted var backdropSizes = List<String>()
    @Persisted var logoSizes = List<String>()
    @Persisted var posterSizes = List<String>()
    @Persisted var profileSizes = List<String>()
    @Persisted var stillSizes = List<String>()

    convenience init(images: MovieConfiguration.Images?) {
        self.init(value: images?.toDictionary() ?? [:])
    }
}
