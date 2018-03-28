//
//  Date+Extension.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/27/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation

extension Date {
    static func dateFromString(_ string: String?) -> Date? {
        guard let str = string else { return nil }
        let formatter        = DateFormatter()
        formatter.locale     = .current
        formatter.timeZone   = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return formatter.date(from: str)
    }
}
