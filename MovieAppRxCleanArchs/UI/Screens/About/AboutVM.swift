//
//  AboutVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import Foundation

struct AboutInput: ViewModelInput {}

struct AboutOutput: ViewModelOutput {}

class AboutVM: AppViewModel {
    var dataSource: AboutDataSource
    var coordinator: AboutCoordinator

    init(dataSource: AboutDataSource, coordinator: AboutCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }

    func transform(input: AboutInput) -> AboutOutput {
        return AboutOutput()
    }
}
