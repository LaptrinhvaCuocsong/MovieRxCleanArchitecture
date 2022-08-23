//
//  ProfileVM.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 19/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

struct ProfileInput: ViewModelInput {
    var data: Driver<ProfileDataSource>
    var stateEdidtedTrigger: Driver<Bool>
    var stateShowAllHistoryTrigger: Driver<Bool>
}

struct ProfileOutput: ViewModelOutput {
    var stateEdidted: Driver<Bool>
    var stateShowAllHistory: Driver<Bool>
    var profile: Driver<ProfileDataSource>
}

class ProfileVM: AppViewModel {
    var dataSource: ProfileDataSource
    var coordinator: ProfileCoordinator
    private var stateEdited = BehaviorRelay<Bool>(value: true)
    private var stateShowAll = BehaviorRelay<Bool>(value: false)
    private var disposeBag = DisposeBag()
    
    init(dataSource: ProfileDataSource, coordinator: ProfileCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    func transform(input: ProfileInput) -> ProfileOutput {
        input.data.drive { profile in
            self.dataSource = profile
        }
        .disposed(by: disposeBag)
        input.stateEdidtedTrigger.drive { isEdited in
            self.stateEdited.accept(isEdited)
        }
        .disposed(by: disposeBag)
        
        input.stateShowAllHistoryTrigger.drive { isShowAll in
            print(isShowAll)
        }
        .disposed(by: disposeBag)

        return ProfileOutput(stateEdidted: stateEdited.asDriverOnErrorJustComplete(),
                             stateShowAllHistory: stateShowAll.asDriverOnErrorJustComplete(),
                             profile: input.data.asDriver())
    }
}
