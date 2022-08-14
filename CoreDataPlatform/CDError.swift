//
//  CDError.swift
//  CoreDataPlatform
//
//  Created by hungnm98 on 08/08/2022.
//

import Foundation

public enum CDError: Error {
    case modelNotFound

    public var localizedDescription: String {
        switch self {
        case .modelNotFound:
            return "Model not found"
        }
    }
}
