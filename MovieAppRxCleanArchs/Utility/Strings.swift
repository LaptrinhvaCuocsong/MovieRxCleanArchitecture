//
//  Strings.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import Foundation

struct Strings {
    struct Tabbar {
        static var movieList: String {
            return "tabbar_movieList".localized()
        }

        static var movieFavorite: String {
            return "tabbar_movieFavorite".localized()
        }

        static var setting: String {
            return "tabbar_setting".localized()
        }

        static var about: String {
            return "tabbar_about".localized()
        }
    }

    struct MovieList {
        static var title: String {
            return "movieList_title".localized()
        }
    }

    struct MovieFavorite {
        static var title: String {
            return "movieFavorite_title".localized()
        }
    }

    struct Setting {
        static var title: String {
            return "setting_title".localized()
        }
    }

    struct About {
        static var title: String {
            return "about_title".localized()
        }
    }
}
