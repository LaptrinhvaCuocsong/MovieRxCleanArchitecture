//
//  UICollectionView+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 24/07/2022.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: Bundle.main)
        register(nib, forCellWithReuseIdentifier: String(describing: type))
    }

    func registerCells(types: [UICollectionViewCell.Type]) {
        types.forEach({ registerCell(type: $0) })
    }

    func dequeueCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}
