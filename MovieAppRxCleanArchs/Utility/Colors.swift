//
//  Colors.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import UIKit

struct Colors {
    static var tintColor: UIColor {
        return color(lightModeColor: UIColor(hex: 0x0984e3))
    }
    
    static var defaultScreenBackgroundColor: UIColor {
        return color(lightModeColor: UIColor.white)
    }
    
    static func tabbarItemTitleColor(isSelected: Bool) -> UIColor {
        return isSelected ? color(lightModeColor: UIColor.white) : color(lightModeColor: UIColor(hex: 0xADADAD))
    }
    
    static private func color(lightModeColor: UIColor, darkModeColor: UIColor? = nil) -> UIColor {
        let darkModeColor: UIColor = darkModeColor ?? lightModeColor
        switch Helper.userInterfaceStyle {
        case .dark:
            return darkModeColor
        default:
            return lightModeColor
        }
    }
}
