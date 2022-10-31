//
//  Observable+Ext.swift
//  RealmPlatform
//
//  Created by hungnm98 on 29/10/2022.
//

import Foundation
import RealmSwift
import RxSwift

extension Result where Success: Sequence, Success.Element: Persistable {
    func toDomains() -> Result<[Success.Element.DomainType], Error> {
        switch self {
        case let .success(persitables):
            return .success(persitables.toDomains())
        case let .failure(error):
            return .failure(error)
        }
    }
}

extension Sequence where Element: Persistable {
    func toDomains() -> [Element.DomainType] {
        return map({ $0.asDomain() })
    }
}
