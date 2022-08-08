//
//  RepositoryModule.swift
//  Partner
//
//  Created by hungnm98 on 07/06/2022.
//  Copyright © 2022 Tripi. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform
import CoreData

class RepositoryModule: DIModule {
    
    
    func registerServices(serviceLocator: ServiceLocator) {
        serviceLocator.registerLazySingleton(UseCaseProvider.self, name: "NetworkPlatform.UseCaseProvider") { _ in
            return NetworkPlatform.UseCaseProvider()
        }
        
//        serviceLocator.registerLazySingleton(UseCaseProvider.self, name: "CoreDataPlatform.UseCaseProvider") { _ in
//            return Netwo
//        }
//
//        serviceLocator.registerLazySingleton(MoviesUseCase.self, name: "NetworkPlatform.MovieUseCase") { _ in
//            <#code#>
//        }
    }
}
