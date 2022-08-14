//
//  MovieConfigurationUseCase.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 03/08/2022.
//

import Domain
import Foundation
import RxSwift

class MovieConfigurationUseCase: Domain.MovieConfigurationUseCase {
    private let network: MovieConfigurationNetwork

    init(network: MovieConfigurationNetwork) {
        self.network = network
    }

    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>> {
        return network.fetchMovieConfiguration()
    }

    func saveMovieConfiguration(_ movieConfiguration: MovieConfiguration) -> Observable<Result<Bool, Error>> {
        return Observable.empty()
    }
}
