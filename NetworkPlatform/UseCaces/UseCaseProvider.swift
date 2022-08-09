//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 06/06/2022.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        self.networkProvider = NetworkProvider()
    }
    
    public func makeMoviesUseCase() -> Domain.MoviesUseCase? {
        return MoviesUseCase(network: networkProvider.makeMoviesNetwork())
    }
    
    public func makeMovieConfigurationUseCase() -> Domain.MovieConfigurationUseCase? {
        return MovieConfigurationUseCase(network: networkProvider.makeMovieConfigurationNetwork())
    }
}
