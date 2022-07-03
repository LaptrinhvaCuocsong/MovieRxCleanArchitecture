//
//  Application.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 22/05/2022.
//

import Foundation
import NetworkPlatform
import Domain
import UIKit

final class Application {
    static let shared = Application()
    weak var baseSideMenu: BaseSideMenuVC!
    let networkUseCaseProvider: Domain.UseCaseProvider

    // UseCases

    private init() {
        networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configMainInterface(in window: UIWindow) {
        let movieListNC = BaseNC()
        movieListNC.tabBarItem = UITabBarItem(title: Strings.Tabbar.movieList,
                                              image: Images.Tabbar.icMovieListTabbar(isSelected: false),
                                              selectedImage: Images.Tabbar.icMovieListTabbar(isSelected: true))
        let movieListVC = MovieListVC(viewModel: MovieListVM(dataSource: DefaultMovieListDataSource(),
                                                             coordinator: MovieListCoordinator(navigationController: movieListNC),
                                                             moviesUseCase: networkUseCaseProvider.makeMoviesUseCase()))
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

        window.rootViewController = baseSideMenuVC
        window.makeKeyAndVisible()
    }
}
