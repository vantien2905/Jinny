//
//  PopUpHelper.swift
//  Prelens-jinny
//
//  Created by Edward Nguyen on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation

class PopUpHelper {
    static let shared = PopUpHelper()
    
    func showMessage(message: String) {
        DispatchQueue.main.async {
            let popUp = PopUpView()
            popUp.showPopUp(message: message)
        }
    }
    
    func showPopUp(message: String, action: @escaping () -> Void) {
        DispatchQueue.main.async {
            let popUp = PopUpView()
            popUp.showPopUp(message: message, completion: action)
        }
    }
}
