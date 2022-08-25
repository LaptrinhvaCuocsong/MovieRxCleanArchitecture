//
//  MoviesRepository.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import Domain
import Foundation
import RxSwift

protocol MoviesRepository {
    func popularMovies(page: Int, limit: Int?) -> Observable<Result<Movies, Error>>
    func save(_ movie: Movie) -> Observable<Result<Bool, Error>>
    func checkFavorite(for movies: [Movie]) -> Observable<Result<[Movie], Error>>
}
