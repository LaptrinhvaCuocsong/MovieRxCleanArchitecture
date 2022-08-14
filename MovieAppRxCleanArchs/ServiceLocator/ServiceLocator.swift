//
//  RepositoryLocator.swift
//  Partner
//
//  Created by hungnm98 on 07/06/2022.
//  Copyright © 2022 Tripi. All rights reserved.
//

import Foundation

@inline(__always) func getService<T>(_ type: T.Type, name: String? = nil) -> T? {
    return ServiceLocator.shared.get(name: name)
}

func registerDIModules(_ modules: [DIModule]) {
    modules.forEach({ $0.registerServices(serviceLocator: ServiceLocator.shared) })
}

class ServiceLocator {
    typealias ServiceLocatorFactory<T> = (ServiceLocator) -> T

    static let shared = ServiceLocator()

    private lazy var factoryServices: [String: (isFactory: Bool, factory: ServiceLocatorFactory<Any>)] = [:]
    private lazy var services: [String: Any] = [:]
    private let lock = NSRecursiveLock()

    func registerSingleton<T>(_ serviceType: T.Type,
                              name: String? = nil,
                              factory: @escaping ServiceLocatorFactory<T>) {
        var key = "\(String(describing: serviceType))"
        if let name = name {
            key += "_\(name)"
        }
        lock.lock()
        services[key] = factory(self)
        lock.unlock()
    }

    func registerLazySingleton<T>(_ serviceType: T.Type,
                                  name: String? = nil,
                                  factory: @escaping ServiceLocatorFactory<T>) {
        var key = "\(String(describing: serviceType))"
        if let name = name {
            key += "_\(name)"
        }
        lock.lock()
        factoryServices[key] = (isFactory: false, factory: factory)
        lock.unlock()
    }

    func registerFactory<T>(_ serviceType: T.Type,
                            name: String? = nil,
                            factory: @escaping ServiceLocatorFactory<T>) {
        var key = "\(String(describing: serviceType))"
        if let name = name {
            key += "_\(name)"
        }
        lock.lock()
        factoryServices[key] = (isFactory: true, factory: factory)
        lock.unlock()
    }

    func get<T>(type: T.Type = T.self, name: String? = nil) -> T? {
        var key = "\(String(describing: T.self))"
        if let name = name {
            key += "_\(name)"
        }
        if let service = services[key] as? T {
            return service
        } else {
            guard let factoryService = factoryServices[key] else {
                return nil
            }
            if factoryService.isFactory {
                return factoryService.factory(self) as? T
            } else {
                if let service = services[key] as? T {
                    return service
                } else {
                    let service = factoryService.factory(self)
                    services[key] = service
                    return service as? T
                }
            }
        }
    }
}
