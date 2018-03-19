//
//  UIButton+Extension.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setAttributed(title: String, color: UIColor, font: UIFont?, isUnderLine: Bool = false ) {
        var attr = NSAttributedString()
        if isUnderLine {
            attr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font!, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        } else {
            attr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font!])
        }
        self.setAttributedTitle(attr, for: .normal)
    }

}
