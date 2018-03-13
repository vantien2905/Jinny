//
//  NSObject+extension.swift
//  Prelens-jinny
//
//  Created by vinova on 3/7/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation

public extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
}
