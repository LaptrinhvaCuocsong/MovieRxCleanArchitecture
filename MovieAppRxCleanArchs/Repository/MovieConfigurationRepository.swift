//
//  MovieConfigurationRepository.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 08/08/2022.
//

import Domain
import Foundation
import RxSwift

protocol MovieConfigurationRepository {
    func movieConfigurationFromCache() -> Observable<Result<MovieConfiguration.Images?, Error>>?
    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration.Images?, Error>>?
}
