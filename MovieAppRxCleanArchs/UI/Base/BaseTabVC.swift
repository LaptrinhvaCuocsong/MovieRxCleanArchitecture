//
//  BaseTabVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import UIKit

class BaseTabVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize tabbar
        UITabBar.appearance().backgroundColor = Colors.tintColor
        UITabBar.appearance().unselectedItemTintColor = Colors.tabbarItemTitleColor(isSelected: false)
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.tabbarItemTitleColor(isSelected: true),
                                     NSAttributedString.Key.font: Fonts.Roboto.medium(with: 10)],
                                    for: .selected)
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.font: Fonts.Roboto.medium(with: 10)],
                                    for: .normal)
    }
}
