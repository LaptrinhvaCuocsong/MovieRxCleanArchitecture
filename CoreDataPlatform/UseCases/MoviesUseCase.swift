//
//  MoviesUseCase.swift
//  CoreDataPlatform
//
//  Created by Nguyen Manh Hung on 18/08/2022.
//

import Domain
import Foundation
import RxSwift
import Utils

final class MoviesUseCase<Repository>: Domain.MoviesUseCase where Repository: AbstractRepository, Repository.T == Movie {
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>> {
        let input = (input as? CDPopularMoviesParam) ?? CDPopularMoviesParam(page: 1, limit: 20)
        return Observable.empty()
    }

    func saveMovies(_ movies: [Movie]) -> Observable<Result<Bool, Error>> {
        return Observable.empty()
    }
}
