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

final class MoviesUseCase<Repository>: Domain.MoviesUseCase where Repository: AbstractRepository, Repository.T == Movies {
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>> {
        return Observable.empty()
    }
}
