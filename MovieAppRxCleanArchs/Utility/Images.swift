//
//  Images.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import UIKit

struct Images {
    struct Tabbar {
        static func icMovieListTabbar(isSelected: Bool) -> UIImage? {
            return Images.image(lightModeNamed: isSelected ? "ic_tabbar_movieList_selected" : "ic_tabbar_movieList_unselected")
        }

        static func icMovieFavoriteTabbar(isSelected: Bool) -> UIImage? {
            return Images.image(lightModeNamed: isSelected ? "ic_tabbar_favorite_selected" : "ic_tabbar_favorite_unselected")
        }

        static func icSettingTabbar(isSelected: Bool) -> UIImage? {
            return Images.image(lightModeNamed: isSelected ? "ic_tabbar_setting_selected" : "ic_tabbar_setting_unselected")
        }

        static func icAboutTabbar(isSelected: Bool) -> UIImage? {
            return Images.image(lightModeNamed: isSelected ? "ic_tabbar_about_selected" : "ic_tabbar_about_unselected")
        }
    }

    struct Button {
        static var icBack: UIImage? {
            return Images.image(lightModeNamed: "ic_back")
        }

        static var icClose: UIImage? {
            return Images.image(lightModeNamed: "ic_close")
        }
        
        static var icMenu: UIImage? {
            return Images.image(lightModeNamed: "ic_menu")
        }
        
        static var icList: UIImage? {
            return Images.image(lightModeNamed: "ic_list")
        }
        
        static var icGrid: UIImage? {
            return Images.image(lightModeNamed: "ic_grid")
        }
    }

    private static func image(lightModeNamed: String, darkModeNamed: String? = nil) -> UIImage? {
        let darkModeNamed = darkModeNamed ?? lightModeNamed
        switch Helper.userInterfaceStyle {
        case .dark:
            return UIImage(named: darkModeNamed)?.withRenderingMode(.alwaysOriginal)
        default:
            return UIImage(named: lightModeNamed)?.withRenderingMode(.alwaysOriginal)
        }
    }
}
