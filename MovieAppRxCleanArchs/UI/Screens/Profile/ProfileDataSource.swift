//
//  ProfileDataSource.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 02/07/2022.
//

import Foundation

protocol ProfileDataSource: ViewModelDataSource {
    var name: String { get set }
    var email: String { get set }
    var sex: Bool { get set }
    var history: [String] { get set }
    var birth: Date { get set }
}

struct DefaultProfileDataSource: ProfileDataSource {
    var sex: Bool = true

    var history: [String] = ["1", "2"]

    var name: String = "Nguyen Manh Hung"

    var email: String = "Hungnguyen@gmail.com"

    var birth: Date = Date(timeIntervalSinceNow: 0)
}
