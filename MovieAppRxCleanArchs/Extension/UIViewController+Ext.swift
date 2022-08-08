//
//  UIViewController.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 24/07/2022.
//

import NetworkPlatform
import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        if let error = error as? APIError {
            Alert.present(title: nil, message: error.description, preferredStyle: .alert, actions: .ok(handler: nil), from: self)
        } else {
            Alert.present(title: nil, message: error.localizedDescription, preferredStyle: .alert, actions: .ok(handler: nil), from: self)
        }
    }
}
