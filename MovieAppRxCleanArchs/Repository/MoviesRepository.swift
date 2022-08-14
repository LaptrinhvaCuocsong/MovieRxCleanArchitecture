//
//  MoviesRepository.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import Domain
import Foundation
import RxSwift

protocol MoviesRepository {
    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>>
}
