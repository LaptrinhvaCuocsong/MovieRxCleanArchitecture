//
//  MoviesUseCase.swift
//  RealmPlatform
//
//  Created by user on 01/11/2022.
//

import Domain
import Foundation
import RxSwift

class MoviesUseCase: Domain.MoviesUseCase {
    private let repository: Repository<Movie>

    init(repository: Repository<Movie>) {
        self.repository = repository
    }

    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>> {
        let input = (input as? RPopularMoviesParam) ?? RPopularMoviesParam(page: 1, limit: 20)
        return repository.fetch(page: input.page, limit: input.limit) { objects in
            objects.sorted(by: \.createAt, ascending: true)
        }
        .map({ $0.to(tranform: { Movies(page: input.page,
                                        results: $0,
                                        totalPages: nil,
                                        totalResults: nil,
                                        pageSize: input.limit) }) })
    }

    func popularMovies(ids: [Int]) -> Observable<Result<[Movie], Error>> {
        return Observable.empty()
    }

    func save(movies: [Movie]) -> Observable<Result<Bool, Error>> {
        return repository.save(entities: movies)
    }

    func save(movie: Movie) -> Observable<Result<Bool, Error>> {
        return repository.save(entity: movie)
    }
}
