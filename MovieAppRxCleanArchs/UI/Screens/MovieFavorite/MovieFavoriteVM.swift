//
//  MovieFavoriteVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import Foundation

struct MovieFavoriteInput: ViewModelInput {}

struct MovieFavoriteOutput: ViewModelOutput {}

class MovieFavoriteVM: AppViewModel {
    typealias Input = MovieFavoriteInput
    typealias Output = MovieFavoriteOutput
    typealias Coordinator = MovieFavoriteCoordinator

    var dataSource: MovieFavoriteDataSource
    var coordinator: MovieFavoriteCoordinator

    init(dataSource: MovieFavoriteDataSource, coordinator: MovieFavoriteCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }

    func transform(input: MovieFavoriteInput) -> MovieFavoriteOutput {
        return MovieFavoriteOutput()
    }
}
