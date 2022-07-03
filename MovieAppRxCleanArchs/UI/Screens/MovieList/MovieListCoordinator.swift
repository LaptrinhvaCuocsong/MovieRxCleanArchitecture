//
//  MovieListNavi.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 06/06/2022.
//

import UIKit

class MovieListCoordinator: AppCoordinator {
    weak var navigationController: UINavigationController?

    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
