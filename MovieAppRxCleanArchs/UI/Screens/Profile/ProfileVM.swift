//
//  ProfileVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 19/06/2022.
//

import Foundation

struct ProfileInput: ViewModelInput {}

struct ProfileOutput: ViewModelOutput {}

class ProfileVM: AppViewModel {
    var dataSource: ProfileDataSource
    var coordinator: ProfileCoordinator
    
    init(dataSource: ProfileDataSource, coordinator: ProfileCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    func transform(input: ProfileInput) -> ProfileOutput {
        return ProfileOutput()
    }
}
