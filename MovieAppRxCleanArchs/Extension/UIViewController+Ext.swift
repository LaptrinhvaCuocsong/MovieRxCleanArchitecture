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
        Alert.present(title: nil, message: error.localizedDescription, preferredStyle: .alert, actions: .ok(handler: nil), from: self)
    }
}
