//
//  MoviesRepositoryImpl.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import Domain
import Foundation
import RxSwift
import NetworkPlatform

class MoviesRepositoryImpl: MoviesRepository {
    private let nwMoviesUseCase: MoviesUseCase

    init(nwMoviesUseCase: MoviesUseCase) {
        self.nwMoviesUseCase = nwMoviesUseCase
    }

    func popularMovies(page: Int, limit: Int?) -> Observable<Result<Movies, Error>> {
        let input = PopularMovieParams(page: page)
        return nwMoviesUseCase.popularMovies(input: input)
    }
}
