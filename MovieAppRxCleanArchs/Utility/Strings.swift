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

    struct Button {
        static var ok: String {
            return "btn_ok".localized()
        }

        static var cancel: String {
            return "btn_cancel".localized()
        }

        static var retry: String {
            return "btn_retry".localized()
        }

        static var done: String {
            return "btn_done".localized()
        }
    }

    struct Label {
        static var overview: String {
            return "overview_label".localized()
        }

        static var releaseDate: String {
            return "release_date_label".localized()
        }

        static var rating: String {
            return "rating_label".localized()
        }
    }
}
