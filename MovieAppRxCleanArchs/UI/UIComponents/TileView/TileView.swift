//
//  PPTileView.swift
//  Partner
//
//  Created by hungnm98 on 25/05/2022.
//  Copyright © 2022 Tripi. All rights reserved.
//

import UIKit

class TileView: UIView {
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var lblTitle: UILabel!
    @IBOutlet private var lblValue: UILabel!
    @IBOutlet private var lcWidthTitleLabel: NSLayoutConstraint!
    
    var titleLabelIntrinsicContentSize: CGSize {
        return lblTitle.intrinsicContentSize
    }
    
    var titleWidth: CGFloat? {
        didSet {
            guard let width = titleWidth else { return }
            lcWidthTitleLabel.constant = width
            layoutIfNeeded()
            invalidateIntrinsicContentSize()
        }
    }
    
    var valueLabel: String? {
        get {
            return lblValue.text
        } set {
            let newAttr = NSMutableAttributedString(string: newValue ?? "")
            if let attr = valueAttributeString {
                attr.enumerateAttributes(in: NSRange(location: 0, length: attr.length)) { dict, _, _ in
                    newAttr.addAttributes(dict, range: NSRange(location: 0, length: newAttr.length))
                }
            }
            lblValue.attributedText = newAttr
            invalidateIntrinsicContentSize()
        }
    }
    
    var minSpacing: CGFloat = 40 {
        didSet {
            stackView.spacing = minSpacing
        }
    }

    var titleAttributeString: NSAttributedString? {
        didSet {
            lblTitle.attributedText = titleAttributeString
            invalidateIntrinsicContentSize()
        }
    }
    
    var valueAttributeString: NSAttributedString? {
        didSet {
            lblValue.attributedText = valueAttributeString
            invalidateIntrinsicContentSize()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lcWidthTitleLabel.constant = titleWidth ?? lblTitle.intrinsicContentSize.width
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minSpacing = 80
        lblTitle.font = Fonts.Roboto.regular(with: 14)
        lblTitle.textColor = Colors.greyColor
        lblValue.font = Fonts.Roboto.regular(with: 14)
        lblValue.textColor = Colors.greyColor
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let titleWidth = titleWidth ?? lblTitle.intrinsicContentSize.width
        let maxWidthLblValue = size.width - stackView.spacing - titleWidth
        let valueLabel = lblValue.text ?? ""
        let valueFont = lblValue.font ?? Fonts.Roboto.regular(with: 14)
        let maxHeight: CGFloat = NSString(string: valueLabel).boundingRect(with: CGSize(width: maxWidthLblValue, height: CGFloat.infinity), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : valueFont], context: nil).height
        return CGSize(width: size.width, height: ceil(maxHeight))
    }
}
