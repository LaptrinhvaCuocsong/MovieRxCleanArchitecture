//
//  Helper.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import SVProgressHUD
import UIKit

struct Helper {
    static var userInterfaceStyle: UIUserInterfaceStyle {
        return UITraitCollection.current.userInterfaceStyle
    }

    static func showHUD(_ isShow: Bool) {
        if isShow && !SVProgressHUD.isVisible() {
            SVProgressHUD.show()
        } else if !isShow {
            SVProgressHUD.dismiss()
        }
    }
}
