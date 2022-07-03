//
//  Network.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 06/06/2022.
//

import Alamofire
import Domain
import Foundation
import RxAlamofire
import RxSwift

final class Network<T: Decodable> {
    private let scheduler: ConcurrentDispatchQueueScheduler

    init() {
        scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    func execute(request: URLRequestConvertible) -> Observable<APIResult<T>> {
        return RxAlamofire
            .requestData(request)
            .debug()
            .observe(on: scheduler)
            .map { response, data -> APIResult<T> in
                if 200 ... 299 ~= response.statusCode {
                    if let model = try? JSONDecoder().decode(T.self, from: data) {
                        return APIResult.success(model)
                    } else {
                        return APIResult.failure(APIError.decodingError)
                    }
                } else {
                    if let statusCode = HTTPStatusCode(rawValue: response.statusCode) {
                        return APIResult.failure(APIError.httpError(statusCode.rawValue, statusCode.description))
                    } else {
                        return APIResult.failure(APIError.httpError(response.statusCode, APIConstant.apiErrorMessageCommon))
                    }
                }
            }
    }
}
