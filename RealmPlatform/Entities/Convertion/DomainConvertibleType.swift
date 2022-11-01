//
//  DomainConvertibleType.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RealmSwift
import RxSwift

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}

protocol Persistable: Object, DomainConvertibleType {
    var uid: String { get }
}

protocol RealmRepresentableType {
    associatedtype RealmType: Persistable
    
    var uid: String { get }
    func createNewRealmModel() -> RealmType
    func update(realmModel: RealmType)
}
