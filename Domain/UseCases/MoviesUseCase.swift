//
//  MovieUseCase.swift
//  Domain
//
//  Created by hungnm98 on 21/06/2022.
//

import Foundation
import RxSwift

public protocol MoviesUseCase {
    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>>
    func save(movies: [Movie]) -> Observable<Result<Bool, Error>>
    func save(movie: Movie) -> Observable<Result<Bool, Error>>
}
