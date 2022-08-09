//
//  MovieConfigurationRepository.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 08/08/2022.
//

import Domain
import Foundation

protocol MovieConfigurationRepository {
    func fetchMovieConfiguration() -> Result<MovieConfiguration.Images, Error>?
}
