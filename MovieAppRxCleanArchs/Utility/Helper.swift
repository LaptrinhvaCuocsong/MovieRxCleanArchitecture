//
//  Helper.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import Domain
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

    static func movieImageUrl(size: CGSize? = nil, fileSizeType: MovieFileSizeType?, path: String) -> URL? {
        guard let imageConfig = DataManager.shared.movieImageConfiguration,
              let baseUrl = imageConfig.secureBaseUrl else {
            return nil
        }
        var fileSize = "original"
        if let size = size, let fileSizeType = fileSizeType {
            let sMax = Int(max(size.width, size.height))
            let fileSizes: [String] = imageConfig.fileSizes(fileSizeType)
                .sorted { lhs, rhs in
                    let lhsNumber = Int(lhs.subString(pattern: "\\d+$").last ?? "") ?? 0
                    let rhsNumber = Int(rhs.subString(pattern: "\\d+$").last ?? "") ?? 0
                    return lhsNumber < rhsNumber
                }
            for (i, fSize) in fileSizes.enumerated() {
                let s = Int(fSize.subString(pattern: "\\d+$").last ?? "") ?? 0
                if sMax <= s {
                    fileSize = fileSizes[max(0, i - 1)]
                    break
                }
            }
        }
        let str = baseUrl + fileSize + "/" + path
        return URL(string: str)
    }
}
