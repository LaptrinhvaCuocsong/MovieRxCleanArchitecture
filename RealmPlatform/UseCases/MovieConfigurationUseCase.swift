//
//  MovieConfigurationUseCase.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import Domain
import RxSwift

final class MovieConfigurationUseCase: Domain.MovieConfigurationUseCase {
    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>> {
        fatalError()
    }
    
    func saveMovieConfiguration(_ movieConfiguration: MovieConfiguration) -> Observable<Result<Bool, Error>> {
        fatalError()
    }
}
