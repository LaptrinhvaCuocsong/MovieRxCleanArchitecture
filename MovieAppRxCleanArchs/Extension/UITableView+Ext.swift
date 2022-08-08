//
//  UITableView+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 24/07/2022.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: String(describing: type))
    }

    func dequeueCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
}
