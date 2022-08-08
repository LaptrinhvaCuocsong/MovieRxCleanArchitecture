//
//  Application.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 22/05/2022.
//

import Domain
import Foundation
import NetworkPlatform
import UIKit

final class Application {
    static let shared = Application()
    weak var window: UIWindow?
    weak var baseSideMenu: BaseSideMenuVC?

    // UseCases

    private init() {
    }

    func configSplashInterface() {
        let splashVC = SplashVC(viewModel: SplashVM(coordinator: SplashCoordinator(navigationController: nil)))
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }

    func configMainInterface() {
        let movieListNC = BaseNC()
        movieListNC.tabBarItem = UITabBarItem(title: Strings.Tabbar.movieList,
                                              image: Images.Tabbar.icMovieListTabbar(isSelected: false),
                                              selectedImage: Images.Tabbar.icMovieListTabbar(isSelected: true))
        let movieListVC = MovieListVC(viewModel: MovieListVM(coordinator: MovieListCoordinator(navigationController: movieListNC)))
        movieListNC.pushViewController(movieListVC, animated: false)

        let movieFavoriteNC = BaseNC()
        movieFavoriteNC.tabBarItem = UITabBarItem(title: Strings.Tabbar.movieFavorite,
                                                  image: Images.Tabbar.icMovieFavoriteTabbar(isSelected: false),
                                                  selectedImage: Images.Tabbar.icMovieFavoriteTabbar(isSelected: true))
        let movieFavoriteVC = MovieFavoriteVC(viewModel: MovieFavoriteVM(dataSource: DefaultMovieFavoriteDataSource(), coordinator: MovieFavoriteCoordinator(navigationController: movieFavoriteNC)))
        movieFavoriteNC.pushViewController(movieFavoriteVC, animated: false)

        let settingNC = BaseNC()
        settingNC.tabBarItem = UITabBarItem(title: Strings.Tabbar.setting,
                                            image: Images.Tabbar.icSettingTabbar(isSelected: false),
                                            selectedImage: Images.Tabbar.icSettingTabbar(isSelected: true))
        let settingVC = SettingVC(viewModel: SettingVM(dataSource: DefaultSettingDataSource(), coordinator: SettingCoordinator(navigationController: settingNC)))
        settingNC.pushViewController(settingVC, animated: false)

        let aboutNC = BaseNC()
        aboutNC.tabBarItem = UITabBarItem(title: Strings.Tabbar.about,
                                          image: Images.Tabbar.icAboutTabbar(isSelected: false),
                                          selectedImage: Images.Tabbar.icAboutTabbar(isSelected: true))
        let aboutVC = AboutVC(viewModel: AboutVM(dataSource: DefaultAboutDataSource(), coordinator: AboutCoordinator(navigationController: aboutNC)))
        aboutNC.pushViewController(aboutVC, animated: false)

        let tabbarVC = BaseTabVC()
        tabbarVC.viewControllers = [movieListNC, movieFavoriteNC, settingNC, aboutNC]

        let baseSideMenuVC = BaseSideMenuVC(contentViewController: tabbarVC, menuViewController: UIViewController())
        baseSideMenu = baseSideMenuVC

        window?.rootViewController = baseSideMenuVC
        window?.makeKeyAndVisible()
    }
}
