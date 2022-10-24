//
//  Object+Rx.swift
//  RealmPlatform
//
//  Created by user on 20/10/2022.
//

import Foundation
import RxSwift
import RealmSwift

extension Reactive where Base: Object {
    func first<R: Object>(ofType: R.Type = R.self, with query: (R) -> Bool) -> Observable<Result<R?, Error>> {
        return Observable<Result<R?, Error>>.create { observer in
            return Disposables.create {}
        }
    }
    
    func sync<C: RealmRepresentableType, R>(entity: C,
                                            update: @escaping (R) -> Void) -> Observable<Result<R, Error>> where C.RealmType == R {
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
