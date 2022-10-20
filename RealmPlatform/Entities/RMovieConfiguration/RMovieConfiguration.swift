//
//  RMovieConfiguration.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RealmSwift


class RMovieConfiguration: Object {
    @Persisted var images: RImageMovieConfiguration?
}

class RImageMovieConfiguration: EmbeddedObject {
    @Persisted var baseUrl: String?
    @Persisted var secureBaseUrl: String?
    @Persisted var backdropSizes: List<String>
    @Persisted var logoSizes: List<String>
    @Persisted var posterSizes: List<String>
    @Persisted var profileSizes: List<String>
    @Persisted var stillSizes: List<String>
}
