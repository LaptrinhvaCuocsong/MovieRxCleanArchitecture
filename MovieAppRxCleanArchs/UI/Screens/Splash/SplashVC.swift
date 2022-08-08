//
//  SplashVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 03/08/2022.
//

import Domain
import RxCocoa
import RxSwift
import UIKit

class SplashVC: BaseVC {
    private var viewModel: SplashVM
    private let disposeBag = DisposeBag()

    init(viewModel: SplashVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func binding() {
        let viewDidLoadTrigger = Driver.just(()).delay(.milliseconds(300))
        let input = SplashVM.Input(viewDidLoadTrigger: viewDidLoadTrigger)
        let output = viewModel.transform(input: input)

        output.movieConfiguration
            .drive { [weak self] result in
                guard let self = self else { return }
                self.handleMoveConfiguration(result: result)
            }
            .disposed(by: disposeBag)
    }

    private func handleMoveConfiguration(result: Result<MovieConfiguration, Error>) {
        switch result {
        case let .success(configuration):
            viewModel.coordinator.toMainInterface()
        default: break
        }
    }
}
