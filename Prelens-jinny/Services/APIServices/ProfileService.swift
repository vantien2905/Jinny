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
    func updateProfile(fullName: String, email: String, dateOfBirth: String, regionID: Int?, gender: String?) -> Observable<PRUser?>
    func getResidentialRegion() -> Observable<[ResidentialRegion]>
}

class ProfileService: ProfileServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getProfile() -> Observable<PRUser?> {
        return network.rx_Object(url: APIEndpoint.Profile.getProfile, method: .get, parameters: [:])
    }
    
    func getResidentialRegion() -> Observable<[ResidentialRegion]> {
        return network.rx_Array(url: APIEndpoint.Profile.getRegion, method: .get, parameters: [:])
    }
    
    func updateProfile(fullName: String, email: String, dateOfBirth: String,regionID: Int? = nil, gender: String? = nil ) -> Observable<PRUser?> {
        let parameters = [
            "full_name"                 : fullName,
            "email"                     : email,
            "dob"                       : dateOfBirth,
            "gender"                    : gender ?? "",
            "residential_region_id"     : regionID ?? 0
            ] as [String : Any]
        
        return network.rx_Object(url: APIEndpoint.Profile.updateProfile, method: .put, parameters: parameters as [String: AnyObject])
    }
}
