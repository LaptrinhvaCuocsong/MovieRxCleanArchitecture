//
//  String_Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import Foundation

extension String {
    // MARK: - handle localized

    func localized() -> String {
        let bundle = Bundle.main
        if let language = bundle.preferredLocalizations.first,
           let path = bundle.path(forResource: language, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: self, table: nil)
        } else if let path = bundle.path(forResource: "en", ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: self, table: nil)
        }
        return self
    }

    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
}
