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
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = Colors.tabbarItemTitleColor(isSelected: false)
        UITabBar.appearance().barTintColor = Colors.tintColor
        UITabBar.appearance().backgroundColor = Colors.tintColor
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.tabbarItemTitleColor(isSelected: true),
                                     NSAttributedString.Key.font: Fonts.Roboto.medium(with: 10)],
                                    for: .selected)
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.font: Fonts.Roboto.medium(with: 10)],
                                    for: .normal)
    }
}
