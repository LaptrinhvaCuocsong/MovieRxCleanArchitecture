//
//  CDMovieConfiguration+Ext.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 04/08/2022.
//

import CoreData
import Domain
import Foundation
import QueryKit
import RxSwift

extension CDMovieConfiguration {
    static var uid: Attribute<String> { return Attribute("uid") }
    static var images: Attribute<CDImageMovieConfiguration> { return Attribute("images") }
}

extension CDMovieConfiguration: DomainConvertibleType {
    func asDomain() -> MovieConfiguration {
        return MovieConfiguration(images: images?.asDomain())
    }
}

extension CDMovieConfiguration: Persistable {
    static var entityName: String {
        return "CDMovieConfiguration"
    }
}

extension MovieConfiguration: CoreDataRepresentable {
    typealias CoreDataType = CDMovieConfiguration

    var uid: String {
        return ""
    }

    func update(entity: CDMovieConfiguration) {
    }
}
