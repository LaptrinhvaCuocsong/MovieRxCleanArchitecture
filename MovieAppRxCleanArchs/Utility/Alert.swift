//
//  Alert.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 24/07/2022.
//

import UIKit

struct Alert {
    @discardableResult
    static func present(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style = .alert, actions: Alert.Action..., from controller: UIViewController) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alertController.addAction(action.alertAction)
        }
        controller.present(alertController, animated: true, completion: nil)
        return alertController
    }
}

extension Alert {
    enum Action {
        case ok(handler: (() -> Void)?)
        case retry(handler: (() -> Void)?)
        case cancel
        case custom(title: String, handler: (() -> Void)?)
        case done

        private var title: String {
            switch self {
            case .ok:
                return Strings.Button.ok
            case .retry:
                return Strings.Button.retry
            case .cancel:
                return Strings.Button.cancel
            case let .custom(title, _):
                return title
            case .done:
                return Strings.Button.done
            }
        }

        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case let .ok(handler):
                return handler
            case let .retry(handler):
                return handler
            case .cancel:
                return nil
            case let .custom(_, handler):
                return handler
            case .done:
                return nil
            }
        }

        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: .default, handler: { _ in
                self.handler?()
            })
        }
    }
}
