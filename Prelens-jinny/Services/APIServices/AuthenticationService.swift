//
//  LoginService.swift
//  Prelens-jinny
//
//  Created by Edward Nguyen on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import Alamofire

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) -> Observable<PRUser?>
    func signUp(email: String, password: String) -> Observable<PRUser?>
    func forgotPassword(email: String) -> Observable<PRForgotPassword?>
}

class AuthenticationService: AuthenticationServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func login(email: String, password: String) -> Observable<PRUser?> {
        let parameters = [
            "email": email,
            "password": password
        ]
        
        return network.rx_Object(url: APILogin.login, method: .post, parameters: parameters as [String : AnyObject])
    }
    
    func signUp(email: String, password: String) -> Observable<PRUser?> {
        let parameters = [
            "email": email,
            "password": password
        ]
        
        return network.rx_Object(url: APILogin.signUp, method: .post, parameters: parameters as [String : AnyObject])
    }
    
    func forgotPassword(email: String) -> Observable<PRForgotPassword?> {
        let parameters = [
            "email": email
        ]
        
        return network.rx_Object(url: APILogin.forgotPassword, method: .post, parameters: parameters as [String : AnyObject])
    }
    
}
