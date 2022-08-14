//
//  DataManager.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import Domain
import Foundation

class DataManager {
    static let shared = DataManager()

    private(set) var movieImageConfiguration: MovieConfiguration.Images?

    private init() {}

    func save(movieImageConfiguration: MovieConfiguration.Images) {
        self.movieImageConfiguration = movieImageConfiguration
    }
}
