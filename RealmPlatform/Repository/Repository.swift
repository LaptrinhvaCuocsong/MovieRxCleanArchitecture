//
//  Repository.swift
//  RealmPlatform
//
//  Created by user on 24/10/2022.
//

import Foundation
import RealmSwift
import RxSwift

final class Repository<R: RealmRepresentableType> {
    private let realmDb: Realm
    private let scheduler = SerialDispatchQueueScheduler(qos: .background)

    init(realmDb: Realm) {
        self.realmDb = realmDb
    }

    func save(entity: R) -> Observable<Result<Bool, Error>> {
        return entity.sync(in: realmDb)
            .flatMapLatest { result -> Observable<Result<Bool, Error>> in
                switch result {
                case let .success(realmData):
                    return self.realmDb.save(entity: realmData)
                case let .failure(error):
                    return Observable.just(Result.failure(error))
                }
            }
    }
}
