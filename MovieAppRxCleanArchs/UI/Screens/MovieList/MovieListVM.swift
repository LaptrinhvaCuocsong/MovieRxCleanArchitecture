//
//  MovieListVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 06/06/2022.
//

import Domain
import Foundation
import NetworkPlatform
import RxCocoa
import RxSwift

struct MovieListInput: ViewModelInput {
    let changeLayoutTrigger: Driver<Void>
    let viewDidLoadTrigger: Driver<Void>
}

struct MovieListOutput: ViewModelOutput {
    let movies: Driver<Result<[Movie], Error>>
    let isLayoutByList: Driver<Bool>
    let isLoading: Driver<Bool>
}

class MovieListVM: AppViewModel {
    var coordinator: MovieListCoordinator

    private var movies: [Movie] = []
    private var page: Int = 0
    private var isEndLoadMore = false
    private let moviesRepository = getService(MoviesRepository.self)
    private let isLayoutByList = BehaviorRelay<Bool>(value: true)
    private let loading = PublishSubject<Bool>()
    private let activityIndicator = ActivityIndicator()
    private let disposeBag = DisposeBag()

    init(coordinator: MovieListCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: - Public methods

    func transform(input: MovieListInput) -> MovieListOutput {
        input.changeLayoutTrigger
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.isLayoutByList.accept(!self.isLayoutByList.value)
            }
            .disposed(by: disposeBag)

        let movies = input.viewDidLoadTrigger
            .asObservable()
            .flatMapLatest({ [unowned self] in
                fetchMovies()
            })
            .asDriverOnErrorJustComplete()

        activityIndicator.asSharedSequence().drive(loading).disposed(by: disposeBag)

        return MovieListOutput(movies: movies,
                               isLayoutByList: isLayoutByList.asDriver(),
                               isLoading: loading.asDriverOnErrorJustComplete())
    }

    func bundleIdentifier(forCellAt indexPath: IndexPath) -> String {
        if isLayoutByList.value {
            return String(describing: MovieListFullWidthCell.self)
        } else {
            return String(describing: MovieListHalfWidthCell.self)
        }
    }

    func getMovies() -> [Movie] {
        return movies
    }

    // MARK: - Private methods

    private func fetchMovies() -> Observable<Result<[Movie], Error>> {
        page += 1
        return moviesRepository!.popularMovies(input: PopularMovieParams(page: page))
            .trackActivity(activityIndicator)
            .do(onNext: { [weak self] result in
                guard let self = self,
                      let movies = result.data,
                      result.error == nil else { return }
                let page = movies.page ?? 0
                let totalPage = movies.totalPages ?? 0
                self.isEndLoadMore = page >= totalPage
            })
            .map { [weak self] result -> Result<[Movie], Error> in
                guard let self = self else {
                    return .success([])
                }
                switch result {
                case let .success(movies):
                    let page = movies.page ?? 1
                    let movies = movies.results ?? []
                    return Result.success(page == 1 ? movies : (self.movies + movies))
                case let .failure(error):
                    return Result.failure(error)
                }
            }
            .do { [weak self] result in
                guard let self = self else { return }
                self.movies = result.data ?? []
            }
    }
}
