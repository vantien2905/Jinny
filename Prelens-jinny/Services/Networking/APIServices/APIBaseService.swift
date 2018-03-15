//
//  APIBaseService.swift
//  Prelens-jinny
//
//  Created by Lamp on 10/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

struct RequestInfo {
    var headers  : HTTPHeaders?
    var fullPath : String
    var params   : [String: Any]
    var method   : HTTPMethod
}

class APIBaseService {
    
    var header: HTTPHeaders {
        var token: String = ""
        if let _token = KeychainManager.shared.getToken() {
            token = _token
        }
        let headers = [
            "Jinny-Http-Token"   : token, //this will be assigned from user model
            "Accept"            : "application/json"
        ]
        return headers
    }
    
    class var _serverPath: String {
        return baseURL
    }
}

extension APIBaseService {

    func execute<T: BaseResponse>(_ requestInfo: RequestInfo, responseType: T.Type) -> Observable<T> {
        return Observable.create { (resp)in
            let request = Alamofire.request(requestInfo.fullPath, method: requestInfo.method,
                                            parameters: requestInfo.params, headers: requestInfo.headers)
            request.responseJSON(completionHandler: { (response) in
                let _json = JSON(response.result.value)
                resp.onNext(Mapper<T>().map(JSONObject: _json.dictionaryObject)!) //todo here
            })
            return Disposables.create()
        }
    }
    
//    func excuteArray<T: BaseResponse>(_ requestInfo: RequestInfo, responseType: T.Type) -> Observable<[T]> {
//        return Observable.create { (resp)in
//            let request = Alamofire.request(requestInfo.fullPath, method: requestInfo.method,
//                                            parameters: requestInfo.params, headers: requestInfo.headers)
//            request.responseJSON(completionHandler: { (response) in
//                let _json = JSON(response.result.value)
//                resp.onNext(Mapper<T>().mapArray(JSONfile: <#T##String#>)(JSONObject: _json.dictionaryObject)!) //todo here
//            })
//            return Disposables.create()
//        }
//    }
//
    
    //    func upload<T: BaseResponse>(_ requestInfo : RequestInfo, responseType: T.Type,
    //                                 succeed: @escaping (String?, Any) -> (),
    //                                 failed : @escaping (String?) -> ()) {
    //
    //        Alamofire.upload(
    //            multipartFormData: { (multipartFormData) in
    //                requestInfo.params.forEach{ (key, value) in
    //                    if let _value = value as? String, let data = _value.data(using: .utf8) {
    //                        multipartFormData.append(data, withName: key)
    //
    //                    } else if let _valueInt = value as? Int, let data = _valueInt.description.data(using: .utf8) {
    //                        multipartFormData.append(data, withName: key)
    //
    //                    } else if let _value = value as? URL {
    //                        multipartFormData.append(_value, withName: key)
    //
    //                    } else if let _value = value as? Data {
    //                        multipartFormData.append(_value, withName: key)
    //
    //                    } else if key == "metadata", let metadata = value as? [[String: Any]] {
    //                        // Currently work only on image
    //                        metadata.forEach { _metadata in
    //                            if  let image    = _metadata["image"] as? UIImage,
    //                                let data     = image.highQualityJPEGNSData as Data?,
    //                                let withName = _metadata["withName"] as? String,
    //                                let fileName = _metadata["fileName"] as? String {
    //
    //                                multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: "image/png")
    //                            }
    //                        }
    //                    }
    //                }
    //        },
    //            to: requestInfo.fullPath,
    //            method: requestInfo.method,
    //            headers: requestInfo.headers) { (result) in
    //                switch result {
    //                case .success(let upload, _, _):
    //
    //                    upload.responseObject { (response: DataResponse<T>) in
    //                        self.processResult(result: response.result, succeed: succeed, failed: failed)
    //                    }
    //
    //                case .failure(let error):
    //                    failed(error.localizedDescription)
    //                }
    //        }
    //    }

    func upload<T: BaseResponse>(_ requestInfo : RequestInfo, responseType: T.Type) -> Observable<T> {
        return Observable.create { resp in
            Alamofire.upload(
                multipartFormData: { (multipartFormData) in
                    requestInfo.params.forEach{ (key, value) in
                        if let _value = value as? String, let data = _value.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                            
                        } else if let _valueInt = value as? Int, let data = _valueInt.description.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                            
                        } else if let _value = value as? URL {
                            multipartFormData.append(_value, withName: key)
                            
                        } else if let _value = value as? Data {
                            multipartFormData.append(_value, withName: key)
                            
                        } else if key == "metadata", let metadata = value as? [[String: Any]] {
                            // Currently work only on image
                            metadata.forEach { _metadata in
                                if  let image    = _metadata["image"] as? UIImage,
                                    let data     = image.highQualityJPEGNSData as Data?,
                                    let withName = _metadata["withName"] as? String,
                                    let fileName = _metadata["fileName"] as? String {
                                    
                                    multipartFormData.append(data, withName: withName,
                                                             fileName: fileName,
                                                             mimeType: "image/png")
                                }
                            }
                        }
                    }
            },
                to: requestInfo.fullPath,
                method: requestInfo.method,
                headers: requestInfo.headers) { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        upload.responseObject { (response: DataResponse<T>) in
                            self.processResult(result: response.result)
                        }
                        
                    case .failure(let error): break
                    }
            }
            return Disposables.create()
        }
    }
    
    
    private func processResult<T: BaseResponse>(result: Result<T>) {
        switch result {
        case .success(let data):
            if data.forbidden {
                return
            }
        case .failure(_): break
            
        }
    }
}


