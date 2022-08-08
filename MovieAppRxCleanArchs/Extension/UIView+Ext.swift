//
//  UIView+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 24/07/2022.
//

import UIKit

extension UIView {
    static func loadFromNib<T: UIView>(type: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: type), owner: nil, options: nil)![0] as! T
    }

    @discardableResult
    func addTileView(title: String, titleFont: UIFont, titleColor: UIColor,
                     value: String, valueFont: UIFont, valueColor: UIColor, valueAlignment: NSTextAlignment = .right,
                     into stackView: UIStackView) -> TileView {
        let tileView = UIView.loadFromNib(type: TileView.self)
        let titleAttr = NSMutableAttributedString(string: title)
        titleAttr.addAttributes([NSAttributedString.Key.font: titleFont,
                                 NSAttributedString.Key.foregroundColor: titleColor],
                                range: NSRange(location: 0, length: title.count))
        tileView.titleAttributeString = titleAttr
        let valueAttr = NSMutableAttributedString(string: value)
        let paragraphStyleAttr = NSMutableParagraphStyle()
        paragraphStyleAttr.alignment = valueAlignment
        valueAttr.addAttributes([NSAttributedString.Key.font: valueFont,
                                 NSAttributedString.Key.foregroundColor: valueColor,
                                 NSAttributedString.Key.paragraphStyle: paragraphStyleAttr],
                                range: NSRange(location: 0, length: value.count))
        tileView.valueAttributeString = valueAttr
        stackView.addArrangedSubview(tileView)
        return tileView
    }
}
