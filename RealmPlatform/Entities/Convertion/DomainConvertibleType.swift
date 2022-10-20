//
//  DomainConvertibleType.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RealmSwift

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}

protocol RealmRepresentableType {
    associatedtype RealmType: Object
    
    var uid: String? { get }
    func update(entity: RealmType)
}
