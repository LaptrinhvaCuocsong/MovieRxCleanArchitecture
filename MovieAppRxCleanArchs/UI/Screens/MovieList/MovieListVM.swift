//
//  MovieListVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 06/06/2022.
//

import Domain
import Foundation
import RxCocoa
import RxSwift

struct MovieListInput: ViewModelInput {
    let changeLayoutTrigger: Driver<Void>
}

struct MovieListOutput: ViewModelOutput {
    let movies: Driver<Movies>
    let isLayoutByList: Driver<Bool>
    let error: Driver<Error>
}

class MovieListVM: AppViewModel {
    var dataSource: MovieListDataSource
    var coordinator: MovieListCoordinator

    private let moviesUseCase: MoviesUseCase
    private let isLayoutByList = BehaviorRelay<Bool>(value: true)
    private let error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()

    init(dataSource: MovieListDataSource,
         coordinator: MovieListCoordinator,
         moviesUseCase: MoviesUseCase) {
        self.dataSource = dataSource
        self.coordinator = coordinator
        self.moviesUseCase = moviesUseCase
    }

    func transform(input: MovieListInput) -> MovieListOutput {
        input.changeLayoutTrigger
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.isLayoutByList.accept(!self.isLayoutByList.value)
            }
            .disposed(by: disposeBag)

        let fetchMovies = moviesUseCase.popularMovies()
            .observe(on: MainScheduler.asyncInstance)

        fetchMovies.share()
            .compactMap({ $0.error })
            .bind(to: error)
            .disposed(by: disposeBag)

        let movies = fetchMovies.share()
            .compactMap({ $0.data }).asDriverOnErrorJustComplete()

        return MovieListOutput(movies: movies,
                               isLayoutByList: isLayoutByList.asDriver(),
                               error: error.asDriverOnErrorJustComplete())
    }
}
