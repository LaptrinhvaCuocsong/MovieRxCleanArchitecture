//
//  MoviesUseCase.swift
//  RealmPlatform
//
//  Created by user on 01/11/2022.
//

import Foundation
import Domain
import RxSwift

class MoviesUseCase: Domain.MoviesUseCase {
    func popularMovies(input: Encodable) -> Observable<Result<Movies, Error>> {
        return Observable.empty()
    }
    
    func popularMovies(ids: [Int]) -> Observable<Result<[Movie], Error>> {
        return Observable.empty()
    }
    
    func save(movies: [Movie]) -> Observable<Result<Bool, Error>> {
        return Observable.empty()
    }
    
    func save(movie: Movie) -> Observable<Result<Bool, Error>> {
        return Observable.empty()
    }
}
