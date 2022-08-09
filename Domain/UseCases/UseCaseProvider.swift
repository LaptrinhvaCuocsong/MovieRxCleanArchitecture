//
//  UseCaseProvider.swift
//  Domain
//
//  Created by hungnm98 on 03/07/2022.
//

import Foundation

public protocol UseCaseProvider {
    func makeMoviesUseCase() -> MoviesUseCase?
    func makeMovieConfigurationUseCase() -> MovieConfigurationUseCase?
}
