//
//  MovieConfigurationRepositoryImpl.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 08/08/2022.
//

import CoreDataPlatform
import Domain
import Foundation
import NetworkPlatform
import RxSwift
import Utils

class MovieConfigurationRepositoryImpl: MovieConfigurationRepository {
    private let networkUseCase: MovieConfigurationUseCase
    private let coreDataUseCase: MovieConfigurationUseCase
    private let realmUseCase: MovieConfigurationUseCase
    private let saveMovieConfiguration = PublishSubject<MovieConfiguration>()
    private let disposeBag = DisposeBag()

    init(networkUseCase: MovieConfigurationUseCase,
         coreDataUseCase: MovieConfigurationUseCase,
         realmUseCase: MovieConfigurationUseCase) {
        self.networkUseCase = networkUseCase
        self.coreDataUseCase = coreDataUseCase
        self.realmUseCase = realmUseCase
        binding()
    }

    private func binding() {
        saveMovieConfiguration
            .flatMapLatest { [unowned self] movieConfiguration -> Observable<Result<Bool, Error>> in
                realmUseCase.saveMovieConfiguration(movieConfiguration)
            }
            .subscribe(onNext: { result in
                switch result {
                case .success:
                    print("❤️❤️❤️ Save MovieConfiguration SUCCESS")
                case let .failure(error):
                    print("😭😭😭 Save MovieConfiguration Error: \(error)")
                }
            })
            .disposed(by: disposeBag)
    }

    func fetchMovieConfiguration() -> Observable<Result<MovieConfiguration.Images?, Error>>? {
        if !NetworkUtility.shared.isNetworkConnected {
            return realmUseCase.fetchMovieConfiguration().map({ $0.to { configuration in configuration.images } })
        }
        return networkUseCase.fetchMovieConfiguration()
            .do(onNext: { [weak self] result in
                guard let self = self, let configuration = result.data else { return }
                self.saveMovieConfiguration.onNext(configuration)
            })
            .map({ $0.to { configuration in configuration.images } })
    }

    func movieConfigurationFromCache() -> Observable<Result<MovieConfiguration.Images?, Error>>? {
        return coreDataUseCase.fetchMovieConfiguration().map({ $0.to(tranform: { $0.images }) })
    }
}
