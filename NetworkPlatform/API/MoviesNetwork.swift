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

    init(network: Network<Movies>) {
        self.network = network
    }

    func popularMovies() -> Observable<APIResult<Movies>> {
        let request = RequestBuilder.getPopularMovies
        return network.execute(request: request)
    }
}
