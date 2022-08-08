//
//  RepositoryProvider.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 04/08/2022.
//

import Domain
import Foundation

final class RepositoryProvider {
    private let coreDataStack: CoreDataStack

    init() {
        coreDataStack = CoreDataStack()
    }

    func makeMovieConfigurationRepository() -> Repository<MovieConfiguration> {
        return Repository<MovieConfiguration>(context: coreDataStack.context)
    }
}
