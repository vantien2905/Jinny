//
//  PopUpHelper.swift
//  Prelens-jinny
//
//  Created by Edward Nguyen on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

class PopUpHelper {
    static let shared = PopUpHelper()
    
    func showMessage(message: String) {
        DispatchQueue.main.async {
            let popUp = PopUpView()
            popUp.showPopUp(message: message)
        }
    }
    
    func showPopUp(message: String, height: CGFloat = 250, action: @escaping () -> Void) {
        DispatchQueue.main.async {
            let popUp = PopUpView()
            popUp.showPopUp(message: message, height: height, completion: action)
        }
    }
    
    func showPopUpSort(message: String, actionLatest: @escaping () -> Void, actionEarliest: @escaping () -> Void) {
        DispatchQueue.main.async {
            let popUp = SortPopUpView()
            popUp.showPopUp(message: message, completionLatest: actionLatest, completionEarliest: actionEarliest)
        }
    }
    
    func showPopUpYesNo(message: String, actionYes: @escaping () -> Void, actionNo: @escaping () -> Void) {
        DispatchQueue.main.async {
            let popUp = PopUpYesNo()
            popUp.showPopUp(message: message, completionYes: actionYes, completionNo: actionNo)
        }
    }
}
