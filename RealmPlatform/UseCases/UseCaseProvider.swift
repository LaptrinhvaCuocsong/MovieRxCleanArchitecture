//
//  UseCaseProvider.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    public func makeMoviesUseCase() -> Domain.MoviesUseCase? {
        return nil
    }
    
    public func makeMovieConfigurationUseCase() -> Domain.MovieConfigurationUseCase? {
        return MovieConfigurationUseCase()
    }
}
