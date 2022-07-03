//
//  Fonts.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 14/06/2022.
//

import UIKit

protocol Fontable {
    static func bold(with size: CGFloat) -> UIFont
    static func medium(with size: CGFloat) -> UIFont
    static func regular(with size: CGFloat) -> UIFont
    static func light(with size: CGFloat) -> UIFont
}

extension Fontable {
    static func bold(with size: CGFloat) -> UIFont {
        let type = String(describing: Self.self)
        return UIFont(name: "\(type)-Bold", size: size * ratioH) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func medium(with size: CGFloat) -> UIFont {
        let type = String(describing: Self.self)
        return UIFont(name: "\(type)-Medium", size: size * ratioH) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func regular(with size: CGFloat) -> UIFont {
        let type = String(describing: Self.self)
        return UIFont(name: "\(type)-Regular", size: size * ratioH) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func light(with size: CGFloat) -> UIFont {
        let type = String(describing: Self.self)
        return UIFont(name: "\(type)-Light", size: size * ratioH) ?? UIFont.systemFont(ofSize: size)
    }
}

struct Fonts {
    struct Roboto: Fontable {
    }
}
