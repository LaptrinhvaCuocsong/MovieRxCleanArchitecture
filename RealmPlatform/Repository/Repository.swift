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

    init(realmDb: Realm) {
        self.realmDb = realmDb
    }

    func fetch(page: Int = 1, limit: Int = 100, resultsCustom: ((Results<R.RealmType>) -> Results<R.RealmType>)?) -> Observable<Result<[R], Error>> {
        realmDb.entities(ofType: R.RealmType.self, page: page, limit: limit, resultsCustom: resultsCustom).map({ $0.toDomains() })
    }

    func save(entity: R) -> Observable<Result<Bool, Error>> {
        return realmDb.save(entity: entity, in: realmDb)
    }
    
    func save(entities: [R]) -> Observable<Result<Bool, Error>> {
        let saveEntities = entities.map({ [unowned self] entity in save(entity: entity) })
        return Observable.combineLatest(saveEntities)
            .map { results in
                if results.contains(where: { $0.data == true }) {
                    return .success(true)
                } else {
                    return .failure(RError.saveModelError)
                }
            }
    }
}
