//
//  MovieConfigurationUseCase.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 08/08/2022.
//

import Domain
import Foundation
import RxSwift

final class MovieConfigurationUseCase<Repository>: Domain.MovieConfigurationUseCase where Repository: AbstractRepository, Repository.T == MovieConfiguration {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>> {
        <#code#>
    }

    func posts() -> Observable<[MovieConfiguration]> {
        return repository.query(with: nil, sortDescriptors: nil)
    }

    func save(post: MovieConfiguration) -> Observable<Void> {
        return repository.save(entity: post)
    }

    func delete(post: MovieConfiguration) -> Observable<Void> {
        return repository.delete(entity: post)
    }
}
