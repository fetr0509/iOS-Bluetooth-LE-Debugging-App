//
//  BLEPeripheral.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/20/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation
import CoreBluetooth

public class BLEPeripheral: NSObject, CBPeripheralManagerDelegate, CBPeripheralDelegate  {
    
    var deviceList: NSMutableArray = []
    var deviceNameList: NSMutableArray = []
    var peripheralManager: CBPeripheralManager!
    var myCBUUID = CBUUID()
    var isReady: Bool = false
    
    override init(){
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    public func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case CBPeripheralManagerState.PoweredOn:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.peripheralChangedState("powered on"))
            break
        case CBPeripheralManagerState.PoweredOff:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.peripheralChangedState("powered off"))
            break
        case CBPeripheralManagerState.Resetting:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.peripheralChangedState("resetting"))
            break
        case CBPeripheralManagerState.Unauthorized:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.peripheralChangedState("unauthorized"))
            break
        case CBPeripheralManagerState.Unsupported:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.peripheralChangedState("unsupported"))
            break
        case CBPeripheralManagerState.Unknown:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.peripheralChangedState("unknown"))
            break
        }
    }
    
    public func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager) {
        
    }
    public func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, willRestoreState dict: [String : AnyObject]) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        
    }
    public func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        
    }
}

