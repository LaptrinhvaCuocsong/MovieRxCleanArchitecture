//
//  MovieNetwork.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 21/06/2022.
//

import Domain
import Foundation
import RxSwift

class MoviesNetwork {
    private let network: Network<Movies>
    private let decoder = JSONDecoder()

    init(network: Network<Movies>) {
        self.network = network
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func popularMovies(param: PopularMovieParams) -> Observable<Result<Movies, Error>> {
        let request = RequestBuilder.v3FetchPopularMovies(param)
        return network.execute(request: request, decoder: decoder)
    }
}
