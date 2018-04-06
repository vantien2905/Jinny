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

var errorQROut: Variable<Bool> = Variable<Bool>(false)
var errorNotExit: Variable<Bool> = Variable<Bool>(false)
var errordidAcquired: Variable<Bool> = Variable<Bool>(false)
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
                if _responseError.code == ErrorCode.errorBarcode.rawValue {
                    print("error Barcode")
                } else if (_responseError.code == ErrorCode.errorQROut.rawValue) {
                    errorQROut.value = true
                    errorNotExit.value = false
                    errordidAcquired.value = false
                } else if (_responseError.code == ErrorCode.errorNotExist.rawValue) {
                    errorNotExit.value = true
                    errorQROut.value = false
                    errordidAcquired.value = false
                } else if (_responseError.code == ErrorCode.didAcquired.rawValue){
                    errorNotExit.value = false
                    errorQROut.value = false
                    errordidAcquired.value = true
                } else if (_responseError.code == ErrorCode.errorTokenInvalid.rawValue) {
                    PopUpHelper.shared.showPopUp(message: _responseError.message& , action: {
                        KeychainManager.shared.deleteAllSavedData()
                        DispatchQueue.main.async {
                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                            appDelegate.goToLogin()
                        }
                    })
                }
                else {
                    PopUpHelper.shared.showMessage(message: _responseError.message&)
                }
                self.statusCode = 0
            }
            
        default: self.statusCode = response.statusCode
        }
    }
}
