//
//  UserService.swift
//  Prelens-jinny
//
//  Created by vinova on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import Alamofire

protocol ProfileServiceProtocol {
    func getProfile() -> Observable<PRUser?>
    func updateProfile(fullName: String, email: String, dateOfBirth: String, gender:String?, residentialRegionID: Int?) -> Observable<PRUser?>
}

class ProfileService: ProfileServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getProfile() -> Observable<PRUser?> {
        return network.rx_Object(url: APIEndpoint.Profile.getProfile, method: .get, parameters: [:])
    }
    
    func updateProfile(fullName: String, email: String, dateOfBirth: String, gender:String?, residentialRegionID: Int?) -> Observable<PRUser?> {
        let parameters = [
            "full_name"             : fullName,
            "email"                 : email,
            "dob"                   : dateOfBirth,
            "gender"                : gender ?? "",
            "residential_region_id" : residentialRegionID ?? ""
            ] as [String : Any]
        
        return network.rx_Object(url: APIEndpoint.Profile.updateProfile, method: .post, parameters: parameters as [String: AnyObject])
    }
}
