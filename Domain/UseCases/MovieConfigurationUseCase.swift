//
//  MovieConfigurationUseCase.swift
//  Domain
//
//  Created by hungnm98 on 03/08/2022.
//

import Foundation
import RxSwift

public protocol MovieConfigurationUseCase {
    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration, Error>>
    func saveMovieConfiguration(_ movieConfiguration: MovieConfiguration) -> Observable<Result<Bool, Error>>
}
