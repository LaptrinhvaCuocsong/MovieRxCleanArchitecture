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
    let movieConfiguration: Driver<Result<MovieConfiguration.Images?, Error>>
}

class SplashVM: AppViewModel {
    var coordinator: SplashCoordinator
    
    private let movieConfigurationRepository = getService(MovieConfigurationRepository.self)

    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }

    func transform(input: SplashInput) -> SplashOutput {
        let movieConfiguration = input.viewDidLoadTrigger
            .asObservable()
            .compactMap({ [unowned self] in movieConfigurationRepository })
            .flatMapLatest { repo in
                repo.fetchMovieConfiguration() ?? Observable.empty()
            }
            .asDriverOnErrorJustComplete()

        return SplashOutput(movieConfiguration: movieConfiguration)
    }
}
