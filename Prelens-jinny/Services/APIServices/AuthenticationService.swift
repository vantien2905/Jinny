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
    func changePassword(currentPassword: String, new_password: String) -> Observable<PRUser?>
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
        
        return network.rx_Object(url: APIEndpoint.Authentication.login, method: .post, parameters: parameters as [String : AnyObject])
    }
    
    func signUp(email: String, password: String) -> Observable<PRUser?> {
        let parameters = [
            "email": email,
            "password": password
        ]
        
        return network.rx_Object(url: APIEndpoint.Authentication.signUp, method: .post, parameters: parameters as [String : AnyObject])
    }
    
    func forgotPassword(email: String) -> Observable<PRForgotPassword?> {
        let parameters = [
            "email": email
        ]
        
        return network.rx_Object(url: APIEndpoint.Authentication.forgotPassword, method: .post, parameters: parameters as [String : AnyObject])
    }
    
    func changePassword(currentPassword: String, new_password: String) -> Observable<PRUser?> {
        let parameters = [
            "current_password": currentPassword,
            "new_password": new_password
        ]
        
        return network.rx_Object(url: APIEndpoint.Authentication.changePassword, method: .put, parameters: parameters as [String : AnyObject])
    }
    
}
