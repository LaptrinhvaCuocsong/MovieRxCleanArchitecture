//
//  MovieListFullWidthCellDataSource.swift
//  MovieAppRxCleanArchs
//
//  Created by Nguyen Manh Hung on 23/08/2022.
//

import Domain
import Foundation

struct MovieListFullWidthCellDataSource: MovieListCellDataSource {
    var movie: Movie?
    var setMovieFavorite: ((Movie) -> Void)?
}
