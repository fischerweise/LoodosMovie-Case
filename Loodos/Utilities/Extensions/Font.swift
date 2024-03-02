//
//  Font.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit

protocol Font {
    func of(size: CGFloat) -> UIFont?
}

extension Font where Self: RawRepresentable, Self.RawValue == String {
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}

enum Avenir: String, Font {
    case bold = "AvenirNext-Bold"
    case demibold = "AvenirNext-DemiBold"
    case heavy = "AvenirNext-Heavy"
    case medium = "AvenirNext-Medium"
    case regular = "AvenirNext-Regular"
}


