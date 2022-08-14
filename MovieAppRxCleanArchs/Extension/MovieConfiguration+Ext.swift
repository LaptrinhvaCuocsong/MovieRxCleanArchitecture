//
//  MovieConfiguration+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/08/2022.
//

import Domain
import Foundation

enum MovieFileSizeType {
    case backdrop
    case logo
    case poster
    case profile
    case still
}

extension MovieConfiguration.Images {
    func fileSizes(_ type: MovieFileSizeType) -> [String] {
        switch type {
        case .backdrop:
            return backdropSizes ?? []
        case .logo:
            return logoSizes ?? []
        case .poster:
            return posterSizes ?? []
        case .profile:
            return profileSizes ?? []
        case .still:
            return stillSizes ?? []
        }
    }
}
