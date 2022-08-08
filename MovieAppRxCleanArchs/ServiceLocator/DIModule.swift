//
//  DIModule.swift
//  Partner
//
//  Created by hungnm98 on 07/06/2022.
//  Copyright © 2022 Tripi. All rights reserved.
//

import Foundation

protocol DIModule {
    func registerServices(serviceLocator: ServiceLocator)
}
