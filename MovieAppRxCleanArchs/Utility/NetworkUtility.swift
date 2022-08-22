//
//  NetworkUtility.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 08/08/2022.
//

import Foundation
import Network
import RxRelay
import RxSwift

enum NetworkStatus {
    case connected
    case notConnect
    case unknown
}

class NetworkUtility {
    static var shared = NetworkUtility()

    private let monitor = NWPathMonitor()
    private let networkStatus = BehaviorRelay<NetworkStatus>(value: .unknown)

    var status: NetworkStatus {
        return networkStatus.value
    }

    var isNetworkConnected: Bool {
        return status == .connected
    }

    init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            if path.status == .unsatisfied {
                networkStatus.accept(.notConnect)
            } else {
                networkStatus.accept(.connected)
            }
        }
    }

    func start() {
        monitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }
}
