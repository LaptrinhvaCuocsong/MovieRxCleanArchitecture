//
//  MovieListCellDataSource.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 27/07/2022.
//

import Domain
import Foundation

protocol MovieListCellDataSource {
    var movie: Movie? { get }
}

struct DefaultMovieListCellDataSource: MovieListCellDataSource {
    var movie: Movie?
}
