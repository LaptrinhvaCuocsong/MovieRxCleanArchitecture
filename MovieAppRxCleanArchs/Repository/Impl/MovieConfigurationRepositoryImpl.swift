//
//  MovieConfigurationRepositoryImpl.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 08/08/2022.
//

import CoreDataPlatform
import Domain
import Foundation
import NetworkPlatform

class MovieConfigurationRepositoryImpl: MovieConfigurationRepository {
    private let networkUseCase: MoviesUseCase?
    private let coreDataUseCase: MovieConfigurationUseCase?
    private let networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    private let coreDataUseCaseProvider = CoreDataPlatform.UseCaseProvider()

    init() {
        networkUseCase = networkUseCaseProvider.makeMoviesUseCase()
        coreDataUseCase = coreDataUseCaseProvider.makeMovieConfigurationUseCase()
    }

    func fetchMovieConfiguration() -> Result<MovieConfiguration.Images, Error>? {
        if NetworkUtility.shared.status == .notConnect {
            return coreDataUseCase?.fetchMovieConfiguration().map({ result in
                switch result {
                }
            })
        return nil
    }
}
