//
//  MovieConfigurationUseCase.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Domain
import Foundation
import RxSwift

final class MovieConfigurationUseCase: Domain.MovieConfigurationUseCase {
    private let repository: Repository<MovieConfiguration>

    init(repository: Repository<MovieConfiguration>) {
        self.repository = repository
    }

    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>> {
        return repository.fetch { objects in
            objects.where { query in
                query.id.equals(String(describing: MovieConfiguration.self))
            }
        }
        .map { result in
            switch result {
            case let .success(movies):
                guard let config = movies.first else {
                    return .failure(RError.modelNotFound)
                }
                return .success(config)
            case let .failure(error):
                return .failure(error)
            }
        }
    }

    func saveMovieConfiguration(_ movieConfiguration: MovieConfiguration) -> Observable<Result<Bool, Error>> {
        repository.save(entity: movieConfiguration)
    }
}
