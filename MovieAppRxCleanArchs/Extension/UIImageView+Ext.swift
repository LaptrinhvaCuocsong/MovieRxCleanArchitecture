//
//  UIImageView+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 31/07/2022.
//

import SDWebImage
import UIKit

extension UIImageView {
    func sdSetImage(url: URL?, placehodlerImage: UIImage? = nil, completion: ((UIImage?) -> Void)? = nil) {
        sd_setImage(with: url, placeholderImage: nil, options: []) { image, _, _, _ in
            completion?(image)
        }
    }

    func sdSetMovieImage(path: String, fileSizeType: MovieFileSizeType?, completion: ((UIImage?) -> Void)? = nil) {
        let url = Helper.movieImageUrl(size: frame.size, fileSizeType: fileSizeType, path: path)
        sd_setImage(with: url, placeholderImage: nil, options: []) { image, _, _, _ in
            completion?(image)
        }
    }
}
