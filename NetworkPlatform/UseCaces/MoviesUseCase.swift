//
//  MoviesUseCase.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 23/06/2022.
//

import Foundation
import Domain
import RxSwift

class MoviesUseCase: Domain.MoviesUseCase {
    private let network: MoviesNetwork
    
    init(network: MoviesNetwork) {
        self.network = network
    }
    
    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>> {
        let input = (input as? PopularMovieParams) ?? PopularMovieParams(page: 1)
        return network.popularMovies(param: input)
    }
}
