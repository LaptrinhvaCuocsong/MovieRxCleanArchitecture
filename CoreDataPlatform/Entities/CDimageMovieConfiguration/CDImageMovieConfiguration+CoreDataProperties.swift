//
//  CDImageMovieConfiguration+CoreDataProperties.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 04/08/2022.
//

import CoreData
import Foundation

extension CDImageMovieConfiguration {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImageMovieConfiguration> {
        return NSFetchRequest<CDImageMovieConfiguration>(entityName: "CDImageMovieConfiguration")
    }

    @NSManaged public var uid: String?
    @NSManaged public var baseURL: String?
    @NSManaged public var secureBaseURL: String?
    @NSManaged public var backdropSizes: [String]?
    @NSManaged public var logoSizes: [String]?
    @NSManaged public var posterSizes: [String]?
    @NSManaged public var profileSizes: [String]?
    @NSManaged public var stillSizes: [String]?
}
