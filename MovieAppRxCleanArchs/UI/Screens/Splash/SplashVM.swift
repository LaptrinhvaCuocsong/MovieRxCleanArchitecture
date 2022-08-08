//
//  SplashVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 03/08/2022.
//

import Domain
import Foundation
import RxCocoa
import RxSwift

struct SplashInput: ViewModelInput {
    let viewDidLoadTrigger: Driver<Void>
}

struct SplashOutput: ViewModelOutput {
    let movieConfiguration: Driver<Result<MovieConfiguration, Error>>
}

class SplashVM: AppViewModel {
    var coordinator: SplashCoordinator
    private let movieConfigurationUseCase: MovieConfigurationUseCase? = getService(MovieConfigurationUseCase.self)

    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }

    func transform(input: SplashInput) -> SplashOutput {
        let movieConfiguration = input.viewDidLoadTrigger
            .asObservable()
            .flatMapLatest { [unowned self] _ in
                movieConfigurationUseCase!.fetchMovieConfiguration()
            }
            .asDriverOnErrorJustComplete()

        return SplashOutput(movieConfiguration: movieConfiguration)
    }
}
