//
//  Object+Rx.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RealmSwift
import RxSwift

extension Realm {
    typealias SError = Swift.Error

    func entities<R: Persistable>(ofType: R.Type = R.self, query: @escaping (R) -> Bool) -> Observable<Result<[R], SError>> {
        return Observable<Result<[R], SError>>.create { observer in
            let objects = self.objects(R.self).filter(query)
            var items: [R] = []
            var iterator = objects.makeIterator()
            while let item = iterator.next() {
                items.append(item)
            }
            observer.onNext(Result.success(items))
            return Disposables.create()
        }
    }

    func first<R: Persistable>(ofType: R.Type = R.self, with query: @escaping (R) -> Bool) -> Observable<Result<R?, SError>> {
        return Observable<Result<R?, SError>>.create { observer in
            let firstElement = self.objects(R.self).filter(query).first
            observer.onNext(Result.success(firstElement))
            return Disposables.create()
        }
    }

    func save<C: RealmRepresentableType, R>(entity: C, in realmDb: Realm) -> Observable<Result<Bool, SError>> where C.RealmType == R {
        let query: (R) -> Bool = { r in r.uid == entity.uid }
        return first(with: query)
            .map { result in
                switch result {
                case let .success(realmData):
                    do {
                        try realmDb.write {
                            if let existsModel = realmData {
                                entity.update(realmModel: existsModel)
                            } else {
                                realmDb.add(entity.createNewRealmModel())
                            }
                        }
                        return Result.success(true)
                    } catch {
                        return Result.failure(error)
                    }
                case let .failure(error):
                    return Result.failure(error)
                }
            }
    }
}
