//
//  MovieConfigurationUseCase.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 08/08/2022.
//

import Domain
import Foundation
import RxSwift
import Utils

final class MovieConfigurationUseCase<Repository>: Domain.MovieConfigurationUseCase where Repository: AbstractRepository, Repository.T == MovieConfiguration {
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>> {
        return repository.query(with: nil, sortDescriptors: nil).map { result in
            switch result {
            case let .success(list):
                guard let first = list.first else {
                    return Result.failure(CDError.modelNotFound)
                }
                return Result.success(first)
            case let .failure(error):
                return Result.failure(error)
            }
        }
    }
}
