//
//  SettingVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import Foundation

struct SettingInput: ViewModelInput {}

struct SettingOutput: ViewModelOutput {}

class SettingVM: AppViewModel {
    var dataSource: SettingDataSource
    var coordinator: SettingCoordinator

    init(dataSource: SettingDataSource, coordinator: SettingCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }

    func transform(input: SettingInput) -> SettingOutput {
        return SettingOutput()
    }
}
