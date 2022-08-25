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
    let pullToRefreshTrigger: Driver<Void>
    let loadMoreTrigger: Driver<Void>
}

struct MovieListOutput: ViewModelOutput {
    let movies: Driver<Result<[Movie], Error>>
    let isLayoutByList: Driver<Bool>
    let isLoading: Driver<Bool>
    let movieListVCAction: Driver<MovieListVCAction>
}

class MovieListVM: AppViewModel {
    var coordinator: MovieListCoordinator

    private let moviesSubject = PublishSubject<Result<[Movie], Error>>()
    private var movies: [Movie] = []
    private var page: Int = 0
    private var isEndLoadMore = false
    private let moviesRepository = getService(MoviesRepository.self)
    private let isLayoutByList = BehaviorRelay<Bool>(value: true)
    private let loading = BehaviorRelay<Bool>(value: false)
    private let activityIndicator = ActivityIndicator()
    private let disposeBag = DisposeBag()
    private let movieListVCActionTrigger = PublishSubject<MovieListVCAction>()

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

        Observable.combineLatest(input.viewDidLoadTrigger.asObservable(),
                                 input.pullToRefreshTrigger.asObservable())
            .do { [unowned self] _ in
                resetPage()
            }
            .filter({ [unowned self] _ in !loading.value })
            .flatMapLatest({ [unowned self] _ in
                fetchMovies()
            })
            .bind(to: moviesSubject)
            .disposed(by: disposeBag)

        input.loadMoreTrigger.debounce(.milliseconds(200))
            .asObservable()
            .filter({ [unowned self] _ in !loading.value })
            .flatMapLatest({ [unowned self] _ in
                fetchMovies()
            })
            .bind(to: moviesSubject)
            .disposed(by: disposeBag)

        activityIndicator.asSharedSequence()
            .filter({ [unowned self] _ in page == 1 })
            .drive(loading)
            .disposed(by: disposeBag)

        return MovieListOutput(movies: moviesSubject.asDriverOnErrorJustComplete(),
                               isLayoutByList: isLayoutByList.asDriver(),
                               isLoading: loading.asDriverOnErrorJustComplete(),
                               movieListVCAction: movieListVCActionTrigger.asDriverOnErrorJustComplete())
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

    func checkIsEndLoadMore() -> Bool {
        return isEndLoadMore
    }

    func cellDataSource(forCellAt indexPath: IndexPath) -> MovieListCellDataSource? {
        if isLayoutByList.value {
            return MovieListFullWidthCellDataSource(movie: movies[indexPath.item]) { [weak self] movie in
                guard let self = self else { return }
                self.movies[indexPath.row].setFavorite(movie.getIsFavorite())
                self.movieListVCActionTrigger.onNext(.setFavoriteMovie(movie))
                _ = self.moviesRepository?.save(self.movies[indexPath.row])
            }
        } else {
            return DefaultMovieListCellDataSource(movie: movies[indexPath.item])
        }
    }

    // MARK: - Private methods

    private func resetPage() {
        page = 0
        movies.removeAll()
    }

    private func fetchMovies() -> Observable<Result<[Movie], Error>> {
        page += 1
        return moviesRepository!.popularMovies(page: page, limit: nil)
            .trackActivity(activityIndicator)
            .do(onNext: { [weak self] result in
                guard let self = self,
                      let movies = result.data,
                      result.error == nil else { return }
                self.isEndLoadMore = movies.isEndLoadMore
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
