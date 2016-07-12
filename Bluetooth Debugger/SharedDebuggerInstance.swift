//
//  SharedDebuggerInstance.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/2/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation

class SharedDebuggerInstance {
    
    static let sharedInstance = SharedDebuggerInstance()
    
    lazy var debuggerTextHandler: DebuggerTextHandler = DebuggerTextHandler()
    
}