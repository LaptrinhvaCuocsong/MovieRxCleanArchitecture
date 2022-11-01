//
//  Repository.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import RealmSwift
import RxSwift
import Utils

final class Repository<R: RealmRepresentableType> where R.RealmType.DomainType == R {
    private let realmDb: Realm
    private let scheduler = SerialDispatchQueueScheduler(qos: .background)

    init(realmDb: Realm) {
        self.realmDb = realmDb
    }
    
    func fetch(query: @escaping (R.RealmType) -> Bool) -> Observable<Result<[R], Error>> {
        realmDb.entities(ofType: R.RealmType.self, query: query).map({ $0.toDomains() })
    }

    func save(entity: R) -> Observable<Result<Bool, Error>> {
        return realmDb.save(entity: entity, in: realmDb)
    }
}
