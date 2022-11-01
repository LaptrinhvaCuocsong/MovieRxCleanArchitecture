//
//  List+Ext.swift
//  RealmPlatform
//
//  Created by user on 01/11/2022.
//

import Foundation
import RealmSwift

extension List {
    func toList() -> [Element] {
        map({ $0 })
    }
}
