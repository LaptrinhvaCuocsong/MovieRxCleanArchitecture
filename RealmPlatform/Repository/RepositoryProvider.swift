//
//  RepositoryProvider.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import Domain

final class RepositoryProvider {
    private let realmDb = RealmDataStack.shared.realm
    
    func makeMovieConfigurationRepository() -> Repository<Domain.MovieConfiguration> {
        return Repository<Domain.MovieConfiguration>(realmDb: realmDb)
    }
    
    func makeMoviesRepository() -> Repository<Domain.Movie> {
        return Repository<Domain.Movie>(realmDb: realmDb)
    }
}
