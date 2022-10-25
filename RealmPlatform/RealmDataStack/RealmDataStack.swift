//
//  RealmDataStack.swift
//  RealmPlatform
//
//  Created by user on 18/10/2022.
//

import Foundation
import RealmSwift

class RealmDataStack {
    static let shared = RealmDataStack()
    
    let realm: Realm
    
    private init() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = 1
        if var fileUrl = config.fileURL {
            fileUrl.deleteLastPathComponent()
            fileUrl.appendPathComponent("MovieAppRxCleanArchs")
            fileUrl.appendPathExtension("realm")
            config.fileURL = fileUrl
            print("📂📂📂 Realm storeUrl = \(fileUrl.absoluteString)")
        }
        realm = try! Realm(configuration: config)
    }
}
