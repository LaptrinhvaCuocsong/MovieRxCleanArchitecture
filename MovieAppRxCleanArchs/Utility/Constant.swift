//
//  Constant.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/06/2022.
//

import UIKit

var ratioW: CGFloat {
    return UIScreen.main.bounds.width / Constants.IphoneScreenSize.iPhoneX.width
}

var ratioH: CGFloat {
    return UIScreen.main.bounds.height / Constants.IphoneScreenSize.iPhoneX.height
}

struct Constants {
    struct IphoneScreenSize {
        static let iPhoneX = CGSize(width: 375, height: 812)
    }

    static var statusBarFrame: CGRect {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        return window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
    }

    static var safeAreaInsets: UIEdgeInsets {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        return window?.safeAreaInsets ?? .zero
    }
}
