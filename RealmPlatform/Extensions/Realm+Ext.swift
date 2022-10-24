//
//  Object+Rx.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RxSwift
import RealmSwift

extension Realm {
    typealias SError = Swift.Error
    
    func save<R: Persistable>(entity: R) -> Observable<Result<Bool, SError>> {
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
                case .success(let realmData):
                    let object = realmData ?? R.createEmptyObject()
                    update(object)
                    return Result.success(object)
                case .failure(let error):
                    return Result.failure(error)
                }
            }
    }
}
