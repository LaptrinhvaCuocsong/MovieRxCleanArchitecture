//
//  DomainConvertibleType.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RealmSwift
import RxSwift

protocol Persistable: Object {
    var uid: String { get }
    static func createEmptyObject() -> Self
}

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}

protocol RealmRepresentableType {
    associatedtype RealmType: Persistable
    
    var uid: String { get }
    func update(entity: RealmType)
    func sync(in realmDb: Realm) -> Observable<Result<RealmType, Error>>
}

extension RealmRepresentableType {
    func sync(in realmDb: Realm) -> Observable<Result<RealmType, Error>> {
        return realmDb.sync(entity: self, update: update)
    }
}
