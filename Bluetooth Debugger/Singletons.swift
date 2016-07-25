//
//  Singletons.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/25/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation

class InstanceCache {
    
    static let sharedInstance = InstanceCache()
    
    lazy var BLECentralInstance: BLECentral = BLECentral()
}