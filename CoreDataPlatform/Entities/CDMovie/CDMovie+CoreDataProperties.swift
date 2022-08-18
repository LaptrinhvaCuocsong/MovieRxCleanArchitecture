//
//  CDMovie+CoreDataProperties.swift
//  CoreDataPlatform
//
//  Created by Nguyen Manh Hung on 18/08/2022.
//

import CoreData
import Foundation

extension CDMovie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var uid: String?
    @NSManaged public var adult: NSNumber?
    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIds: [NSNumber]?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: NSNumber?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var video: NSNumber?
    @NSManaged public var voteAverage: NSNumber?
    @NSManaged public var voteCount: NSNumber?
}
