//
//  Observable+Ext.swift
//  Utils
//
//  Created by user on 24/10/2022.
//

import Foundation
import RxSwift

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
