//
//  MovieConfigurationNetwork.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 03/08/2022.
//

import Domain
import Foundation
import RxSwift

class MovieConfigurationNetwork {
    private let network: Network<MovieConfiguration>
    private let decoder = JSONDecoder()

    init(network: Network<MovieConfiguration>) {
        self.network = network
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>> {
        let request = RequestBuilder.v3FetchMovieConfiguration
        return network.execute(request: request, decoder: decoder)
    }
}
