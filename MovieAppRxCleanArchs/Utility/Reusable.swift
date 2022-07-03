//
//  Reusable.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 22/05/2022.
//

import UIKit

extension UITableView {
    func registerReusableCell<T>(ofType cellType: T.Type = T.self) where T: UITableViewCell {
        let nibName = String(describing: cellType)
        register(UINib(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: nibName)
    }
    
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellType),
                                             for: indexPath) as? T else {
            fatalError("Cần register cell \(String(describing: cellType))")
        }
        return cell
    }
    
    func registerHeaderFooter<T>(ofType headerFooterType: T.Type = T.self) where T: UITableViewHeaderFooterView {
        let nibName = String(describing: T.self)
        register(UINib(nibName: nibName, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func dequeueHeaderFooter<T>(ofType headerFooterType: T.Type = T.self) -> T where T: UITableViewHeaderFooterView {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: headerFooterType)) as? T else {
            fatalError("Cần register header footer \(String(describing: headerFooterType))")
        }
        return headerFooterView
    }
}
