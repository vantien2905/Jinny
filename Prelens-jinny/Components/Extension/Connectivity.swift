//
//  Connectivity.swift
//  Prelens-jinny
//
//  Created by vinova on 4/12/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
