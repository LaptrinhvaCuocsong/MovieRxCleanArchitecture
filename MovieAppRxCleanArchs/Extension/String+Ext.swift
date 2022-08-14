//
//  String_Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 12/06/2022.
//

import Foundation

extension String {
    // MARK: - Subscript

    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }

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

    // MARK: - handle regex

    func subString(pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return []
        }
        return regex.matches(in: self, range: NSRange(location: 0, length: count))
            .compactMap({ self[$0.range.location ..< $0.range.upperBound] })
    }
}
