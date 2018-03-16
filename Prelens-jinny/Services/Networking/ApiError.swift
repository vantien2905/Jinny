//
//  ApiError.swift
//  iOSBase
//
//  Created by Edward Nguyen on 3/15/18.
//  Copyright © 2018 sg.vinova.iOSBAse. All rights reserved.
//

import Foundation

class ApiError: Error {
    
    let statusCode: Int
    
    init?(response: Response) {
        switch response.statusCode {
        case 200...299: return nil
        default: self.statusCode = response.statusCode
        }
    }
}
