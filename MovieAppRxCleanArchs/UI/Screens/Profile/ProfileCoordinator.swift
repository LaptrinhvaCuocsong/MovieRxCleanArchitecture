//
//  ProfileCoordinator.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 02/07/2022.
//

import UIKit

class ProfileCoordinator: AppCoordinator {
    weak var navigationController: UINavigationController?

    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
