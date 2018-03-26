//
//  ApiError.swift
//  iOSBase
//
//  Created by Edward Nguyen on 3/15/18.
//  Copyright © 2018 sg.vinova.iOSBAse. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import RxSwift
var scanError: Variable<Bool> = Variable<Bool>(false)

class ApiError: Error {

    let statusCode: Int
//    let responseError: ResponseError?
    init?(response: Response) {
        switch response.statusCode {
        case 200...299:
            let json = JSON(response.data)
            let status = json["status"].boolValue
            if status {
                return nil
            } else {
                let responseError = Mapper<ResponseError>().map(JSONObject: json.dictionaryObject)
                guard let _responseError = responseError else { return nil }
                
                if _responseError.message == "Validation failed: Code has already been taken" {
                    PopUpHelper.shared.showPopUp(message: _responseError.message&, action: {
                        scanError.value = true
                    })
                    
                } else {
                     PopUpHelper.shared.showMessage(message: _responseError.message&)
                }
                self.statusCode = 0
            }

        default: self.statusCode = response.statusCode
        }
    }
}
