//
//  Sequence+Ext.swift
//  Utils
//
//  Created by hungnm98 on 25/08/2022.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }

    subscript(safe range: Range<Int>) -> [Element] {
        var result: [Element] = []
        range.forEach { index in
            if let element = self[safe: index] {
                result.append(element)
            }
        }
        return result
    }
}
