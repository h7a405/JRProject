//
//  Extension.swift
//  JRNetworkingFramework
//
//  Created by Jason Raylegih on 4/10/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//

import UIKit
import CoreBluetooth

typealias Byte = UInt8

extension CBPeripheral {
    var notNull_name : String {
        get {
            return self.name ?? ""
        }
    }
}