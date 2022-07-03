//
//  NaviType.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import UIKit

protocol AppCoordinator {
    var navigationController: UINavigationController? { get }

    init(navigationController: UINavigationController?)
}

extension AppCoordinator {
}
