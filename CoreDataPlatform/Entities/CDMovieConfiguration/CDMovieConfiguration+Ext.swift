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

    static func synced(movieConfiguration: Result<CDMovieConfiguration, Error>, with images: Result<CDImageMovieConfiguration, Error>) -> Result<CDMovieConfiguration, Error> {
        switch movieConfiguration {
        case let .success(movieConfig):
            switch images {
            case let .success(imageConfig):
                movieConfig.images = imageConfig
            default: break
            }
            return .success(movieConfig)
        case let .failure(error):
            return .failure(error)
        }
    }
}

extension MovieConfiguration: CoreDataRepresentable {
    typealias CoreDataType = CDMovieConfiguration

    var uid: String {
        return String(describing: CDMovieConfiguration.self)
    }

    func sync(in context: NSManagedObjectContext) -> Observable<Result<CoreDataType, Error>> {
        let syncSelf = context.rx.sync(entity: self, update: update)
        if let syncImages = images?.sync(in: context) {
            return Observable.zip(syncSelf, syncImages, resultSelector: CDMovieConfiguration.synced(movieConfiguration:with:))
        }
        return syncSelf
    }

    func update(entity: CDMovieConfiguration) {
        entity.uid = uid
    }
}
