//
//  Enum.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation

enum StyleNavigation {
    case left
    case right
}

enum CellRegisterType {
    case tCass
    case tNib
}

enum ErrorCode: Int {
    case errorBarcode  = 2003
    case errorQROut    = 3002
    case errorNotExist = 2002
    case errorTokenInvalid = 1002
}
