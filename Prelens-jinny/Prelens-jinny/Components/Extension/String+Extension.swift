//
//  String+Extension.swift
//  Prelens-jinny
//
//  Created by vinova on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
extension String {
    func isValidEmpty() -> Bool {
        if self.cutWhiteSpace().isEmpty {
            return true
        }
        return (self.cutWhiteSpace().trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "")
    }
    
    func cutWhiteSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isValidPassword() -> Bool {
        if self.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    func checkUrl () -> Bool {
        // create NSURL instance
        if let url = URL(string: self) {
            // check if your application can open the NSURL instance
            //return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}

extension String {
//    func toAttributedString(color: UIColor, font: UIFont? = nil, isUnderLine: Bool = false) -> NSAttributedString {
//        if let font = font {
//            if isUnderLine {
//                return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.underlineColor: color, NSAttributedStringKey.underlineStyle: 1])
//            }
//            return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
//        } else {
//            return NSAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: color])
//        }
//        
//    }
}

extension String {
    func contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

//func isValidEmail() -> Bool {
//    let regex = NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive, error: nil)
//    return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, countElements(self))) != nil
//}

