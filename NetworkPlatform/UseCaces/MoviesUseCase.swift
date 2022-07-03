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
    
    func popularMovies() -> Observable<Result<Movies, Error>> {
        return network.popularMovies().map({ $0.mapToResult() })
    }
}
