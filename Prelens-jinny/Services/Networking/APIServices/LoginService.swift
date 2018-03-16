//
//  LoginService.swift
//  Prelens-jinny
//
//  Created by Edward Nguyen on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import Alamofire

protocol LoginServiceProtocol {
    func login(email: String, password: String) -> Observable<PRUser?>
}

class LoginService: LoginServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func login(email: String, password: String) -> Observable<PRUser?> {
        let body = [
            "email": email,
            "password": password
        ]
        
        return network.rx_Object(url: APILogin.login, method: .post, body: body as [String: AnyObject], header: ["Content-Type": "application/json"])
    }
}
