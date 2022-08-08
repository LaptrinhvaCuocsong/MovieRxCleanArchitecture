//
//  Network.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 06/06/2022.
//

import Alamofire
import Domain
import Foundation
import RxSwift

final class Network<T: Decodable> {
    private let scheduler: ConcurrentDispatchQueueScheduler
    private let sessionManager: Session

    init() {
        scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfiguration.timeoutIntervalForRequest = 30
        sessionManager = Alamofire.Session(configuration: sessionConfiguration)
    }

    func execute(request: URLRequestConvertible, decoder: JSONDecoder) -> Observable<Result<T, Error>> {
        request.urlRequest?.log()
        return Observable.create { [unowned self] e in
            sessionManager.request(request).validate()
                .response { response in
                    response.response?.log(data: response.data)
                    switch response.result {
                    case let .success(data):
                        guard let data = data else {
                            e.onNext(Result.failure(APIError.unknown(APIConstant.apiErrorMessageCommon)))
                            return
                        }
                        do {
                            let model = try decoder.decode(T.self, from: data)
                            e.onNext(Result.success(model))
                        } catch {
                            e.onNext(Result.failure(APIError.decodingError))
                        }
                    case let .failure(error):
                        if (error as NSError).code == NSURLErrorCancelled {
                            e.onNext(Result.failure(APIError.cancel))
                        } else {
                            e.onNext(Result.failure(APIError.httpError(error.responseCode ?? -1, error.localizedDescription)))
                        }
                    }
                }
            return Disposables.create {}
        }
    }
}
