//
//  SplashCoordinator.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 03/08/2022.
//

import UIKit

class SplashCoordinator: AppCoordinator {
    weak var navigationController: UINavigationController?

    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func toMainInterface() {
        Application.shared.configMainInterface()
    }
}
