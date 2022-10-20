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
    func first<R: Object>(ofType: R.Type = R.self, with predicate: (R) -> Bool) -> Observable<Result<R?, Error>> {
        return Observable<Result<R?, Error>>.create { observer in
            
            return Disposables.create {}
        }
    }
    
    func sync<C: RealmRepresentableType, P>(entity: C,
                                           update: @escaping (P) -> Void) -> Observable<Result<P, Error>> where C.RealmType == P {
        
    }
}
