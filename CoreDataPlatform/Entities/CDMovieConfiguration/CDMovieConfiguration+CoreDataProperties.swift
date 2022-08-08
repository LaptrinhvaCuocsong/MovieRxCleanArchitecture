//
//  CDMovieConfiguration+CoreDataProperties.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 04/08/2022.
//

import CoreData
import Foundation

extension CDMovieConfiguration {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovieConfiguration> {
        return NSFetchRequest<CDMovieConfiguration>(entityName: "CDMovieConfiguration")
    }
    
    @NSManaged public var uid: String?
    @NSManaged public var images: CDImageMovieConfiguration?
}
