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
        let images = RImageMovieConfiguration()
        images.baseUrl = images.baseUrl
    }
}
