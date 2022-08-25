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
        return repository.query { request in
            request.fetchLimit = input.limit
            request.fetchOffset = max(0, input.page - 1) * input.limit
            request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: false)]
        }
        .map({ $0.to(tranform: { Movies(page: input.page,
                                        results: $0,
                                        totalPages: nil,
                                        totalResults: nil,
                                        pageSize: input.limit) }) })
    }

    func save(movies: [Movie]) -> Observable<Result<Bool, Error>> {
        return repository.save(entities: movies)
    }
    
    func save(movie: Movie) -> Observable<Result<Bool, Error>> {
        return repository.save(entity: movie)
    }
}
