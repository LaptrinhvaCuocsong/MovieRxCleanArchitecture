//
//  RError.swift
//  RealmPlatform
//
//  Created by hungnm98 on 30/10/2022.
//

import Foundation

public enum RError: Error {
    case modelNotFound
    case saveModelError

    public var localizedDescription: String {
        switch self {
        case .modelNotFound:
            return "Model not found"
        case .saveModelError:
            return "Save model error"
        }
    }
}
