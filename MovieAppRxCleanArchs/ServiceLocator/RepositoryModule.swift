//
//  RepositoryModule.swift
//  Partner
//
//  Created by hungnm98 on 07/06/2022.
//  Copyright © 2022 Tripi. All rights reserved.
//

import CoreDataPlatform
import Domain
import Foundation
import NetworkPlatform
import RealmPlatform

enum RepositoryName: String {
    case nwUseCaseProvider
    case cdUseCaseProvider
    case realmUseCaseProvider
    case nwMovieConfigurationUseCase
    case cdMovieConfigurationUseCase
    case realmMovieConfigurationUseCase
    case nwMoviesUseCase
    case cdMoviesUseCase
}

class RepositoryModule: DIModule {
    func registerServices(serviceLocator: ServiceLocator) {
        serviceLocator.registerLazySingleton(UseCaseProvider.self,
                                             name: RepositoryName.nwUseCaseProvider.rawValue) { _ in
            NetworkPlatform.UseCaseProvider()
        }

        serviceLocator.registerLazySingleton(UseCaseProvider.self,
                                             name: RepositoryName.cdUseCaseProvider.rawValue) { _ in
            CoreDataPlatform.UseCaseProvider()
        }

        serviceLocator.registerLazySingleton(UseCaseProvider.self,
                                             name: RepositoryName.realmUseCaseProvider.rawValue) { _ in
            RealmPlatform.UseCaseProvider()
        }

        registerForMovieConfigurationRepos(serviceLocator: serviceLocator)
        registerForMoviesRepos(serviceLocator: serviceLocator)
    }

    private func registerForMovieConfigurationRepos(serviceLocator: ServiceLocator) {
        serviceLocator.registerFactory(MovieConfigurationUseCase.self,
                                       name: RepositoryName.nwMovieConfigurationUseCase.rawValue) { service in
            service.get(type: NetworkPlatform.UseCaseProvider.self,
                        name: RepositoryName.nwUseCaseProvider.rawValue)!.makeMovieConfigurationUseCase()!
        }

        serviceLocator.registerFactory(MovieConfigurationUseCase.self,
                                       name: RepositoryName.cdMovieConfigurationUseCase.rawValue) { service in
            service.get(type: CoreDataPlatform.UseCaseProvider.self,
                        name: RepositoryName.cdUseCaseProvider.rawValue)!.makeMovieConfigurationUseCase()!
        }

        serviceLocator.registerFactory(MovieConfigurationUseCase.self,
                                       name: RepositoryName.realmMovieConfigurationUseCase.rawValue) { service in
            service.get(type: RealmPlatform.UseCaseProvider.self,
                        name: RepositoryName.realmUseCaseProvider.rawValue)!.makeMovieConfigurationUseCase()!
        }

        serviceLocator.registerLazySingleton(MovieConfigurationRepository.self) { service in
            MovieConfigurationRepositoryImpl(networkUseCase: service.get(type: MovieConfigurationUseCase.self,
                                                                         name: RepositoryName.nwMovieConfigurationUseCase.rawValue)!,
                                             coreDataUseCase: service.get(type: MovieConfigurationUseCase.self,
                                                                          name: RepositoryName.cdMovieConfigurationUseCase.rawValue)!,
                                             realmUseCase: service.get(type: MovieConfigurationUseCase.self,
                                                                       name: RepositoryName.realmMovieConfigurationUseCase.rawValue)!)
        }
    }

    private func registerForMoviesRepos(serviceLocator: ServiceLocator) {
        serviceLocator.registerFactory(MoviesUseCase.self,
                                       name: RepositoryName.nwMoviesUseCase.rawValue) { service in
            service.get(type: NetworkPlatform.UseCaseProvider.self,
                        name: RepositoryName.nwUseCaseProvider.rawValue)!.makeMoviesUseCase()!
        }

        serviceLocator.registerFactory(MoviesUseCase.self,
                                       name: RepositoryName.cdMoviesUseCase.rawValue) { service in
            service.get(type: CoreDataPlatform.UseCaseProvider.self,
                        name: RepositoryName.cdUseCaseProvider.rawValue)!.makeMoviesUseCase()!
        }

        serviceLocator.registerLazySingleton(MoviesRepository.self) { service in
            MoviesRepositoryImpl(nwMoviesUseCase: service.get(type: MoviesUseCase.self,
                                                              name: RepositoryName.nwMoviesUseCase.rawValue)!,
                                 cdMoviesUseCase: service.get(type: MoviesUseCase.self,
                                                              name: RepositoryName.cdMoviesUseCase.rawValue)!)
        }
    }
}
