//
//  UseCaseProvider.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let repositoryProvier = RepositoryProvider()
    
    public init() {}
    
    public func makeMoviesUseCase() -> Domain.MoviesUseCase? {
        return MoviesUseCase(repository: repositoryProvier.makeMoviesRepository())
    }
    
    public func makeMovieConfigurationUseCase() -> Domain.MovieConfigurationUseCase? {
        return MovieConfigurationUseCase(repository: repositoryProvier.makeMovieConfigurationRepository())
    }
}
