//
//  MoviesRepositoryImpl.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import CoreDataPlatform
import Domain
import Foundation
import NetworkPlatform
import RxSwift

class MoviesRepositoryImpl: MoviesRepository {
    private let nwMoviesUseCase: MoviesUseCase
    private let cdMoviesUseCase: MoviesUseCase
    private let saveMovies = PublishSubject<[Movie]>()
    private let disposeBag = DisposeBag()

    init(nwMoviesUseCase: MoviesUseCase, cdMoviesUseCase: MoviesUseCase) {
        self.nwMoviesUseCase = nwMoviesUseCase
        self.cdMoviesUseCase = cdMoviesUseCase
        binding()
    }

    private func binding() {
        saveMovies
            .flatMapLatest { [unowned self] movies -> Observable<Result<Bool, Error>> in
                cdMoviesUseCase.save(movies: movies)
            }
            .subscribe(onNext: { result in
                switch result {
                case .success:
                    print("❤️❤️❤️ Save Movies SUCCESS")
                case let .failure(error):
                    print("😭😭😭 Save Movies Error: \(error)")
                }
            })
            .disposed(by: disposeBag)
    }

    func popularMovies(page: Int, limit: Int?) -> Observable<Result<Movies, Error>> {
        if NetworkUtility.shared.isNetworkConnected {
            let input = PopularMovieParams(page: page)
            return nwMoviesUseCase.popularMovies(input: input)
                .do { [weak self] result in
                    guard let self = self, let movies = result.data?.results else {
                        return
                    }
                    self.saveMovies.onNext(movies)
                }
        } else {
            let input = CDPopularMoviesParam(page: page, limit: limit ?? 20)
            return cdMoviesUseCase.popularMovies(input: input)
        }
    }

    func save(_ movie: Movie) -> Observable<Result<Bool, Error>> {
        return cdMoviesUseCase.save(movie: movie)
    }

    func checkFavorite(for movies: [Movie]) -> Observable<Result<[Movie], Error>> {
        let ids = movies.compactMap({ $0.id })
        return cdMoviesUseCase.popularMovies(ids: ids)
            .map({ $0.to { cdMovies -> [Movie] in
                var result = movies
                for i in 0 ..< result.count {
                    let id = result[i].id
                    result[i].setFavorite(cdMovies.first(where: { $0.id == id })?.getIsFavorite() == true)
                }
                return result
            } })
    }
}
