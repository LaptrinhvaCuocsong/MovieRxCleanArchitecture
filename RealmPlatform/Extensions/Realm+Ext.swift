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

    func save<R: Persistable>(ofType: R.Type = R.self, entity: R) -> Observable<Result<Bool, SError>> {
        return Observable<Result<Bool, SError>>.create { observer in
            do {
                try self.write {
                    self.add(entity, update: .modified)
                }
                observer.onNext(Result.success(true))
            } catch {
                observer.onNext(Result.failure(error))
            }
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

    func sync<C: RealmRepresentableType, R>(entity: C,
                                            update: @escaping (R) -> Void) -> Observable<Result<R, SError>> where C.RealmType == R {
        let query: (R) -> Bool = { r in r.uid == entity.uid }
        return first(with: query)
            .map { result in
                switch result {
                case let .success(realmData):
                    let object = realmData ?? R.createEmptyObject()
                    update(object)
                    return Result.success(object)
                case let .failure(error):
                    return Result.failure(error)
                }
            }
    }
}
