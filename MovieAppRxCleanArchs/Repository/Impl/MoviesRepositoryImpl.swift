//
//  MoviesRepositoryImpl.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import Domain
import Foundation
import RxSwift

class MoviesRepositoryImpl: MoviesRepository {
    private let nwMoviesUseCase: MoviesUseCase

    init(nwMoviesUseCase: MoviesUseCase) {
        self.nwMoviesUseCase = nwMoviesUseCase
    }

    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>> {
        return nwMoviesUseCase.popularMovies(input: input)
    }
}
