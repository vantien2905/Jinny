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
    class var header: HTTPHeaders {
        let headers = [
            "Http-Auth-Token"   : "PRAppData.shared.token", //this will be assigned from user model
            "Accept"            : "application/json",
            "App-Version"       : "appBuildNumberHere",
            "App-Device"        : "iOS"
        ]
        return headers
    }
    
    class var _serverPath: String {
        return baseURL
    }
}

extension APIBaseService {
    //    func execute<T: BaseResponse>(_ requestInfo: RequestInfo, responseType: T.Type,
    //                                  succeed: @escaping (String?, Any) -> (),
    //                                  failed : @escaping (String?) -> ()) {
    //
    //        let request = Alamofire.request(requestInfo.fullPath, method: requestInfo.method,
    //                                        parameters: requestInfo.params, headers: requestInfo.headers)
    //        //response object need to be added into rxswift
    //        request.responseObject { (response: DataResponse<T>) in
    //
    //            self.processResult(result: response.result,
    //                               succeed: succeed, failed: failed)
    //        }
    //    }
    
    
    func execute<T: BaseResponse>(_ requestInfo: RequestInfo, responseType: T.Type) -> Observable<T> {
        return Observable.create { (resp)in
            let request = Alamofire.request(requestInfo.fullPath, method: requestInfo.method,
                                            parameters: requestInfo.params, headers: requestInfo.headers)
            request.responseObject { (response: DataResponse<T>) in
                resp.onNext(Mapper<T>().map(JSONObject: response)!)
                resp.onCompleted()
                self.processResult(result: response.result)
            }
            return DisposeBag() as! Disposable
        }
    }
    
    
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
                                    
                                    multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: "image/png")
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
                            //  self.processResult(result: response.result, succeed: succeed, failed: failed)
                        }
                        
                    case .failure(let error): break
                        //     failed(error.localizedDescription)
                    }
            }
            
            return DisposeBag() as! Disposable
        }
    }
    
    //    private func processResult<T: BaseResponse>(result: Result<T>,
    //                                                succeed: @escaping (String?, Any) -> (),
    //                                                failed : @escaping (String?) -> ()) {
    //        switch result {
    //        case .success(let data):
    //            if data.forbidden {
    //             //   RouterService.shared.gotoAuthentication(animated: true)
    //                return
    //            }
    //
    //            if !data.isSuccess {
    //                failed(data.message)
    //                return
    //            }
    //            succeed(data.message, data.getData)
    //
    //        case .failure(let error):
    //            failed(error.localizedDescription)
    //        }
    //    }
    
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

//Todo: Embbed the RXSwift into the response type, the response result



