//
//  BLECentral.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/20/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation
import CoreBluetooth


protocol BLECentralControllerDelegate: class {
    func hasUpdate(sender: BLECentral)
}

public class BLECentral: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate  {
    
    var deviceList: NSMutableArray = []
    var deviceNameList: NSMutableArray = []
    var discoveredServices: NSMutableArray = []
    var discoveredDescriptors: NSMutableArray = []
    var centralManager: CBCentralManager!
    var connectedDevice: CBPeripheral? = nil
    
    weak var delegate:BLECentralControllerDelegate?
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    public func getDevice(index: Int) -> CBPeripheral? {
        if deviceList.count > index {
            return (deviceList[index] as! CBPeripheral)
        } else {
            return nil
        }
    }
    
    public func connectToDevice(index: Int) -> Void {
        let device = deviceList[index] as! CBPeripheral
        centralManager.connectPeripheral(device, options: nil)
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.attemptConnect(deviceNameList[index] as! String))
        
    }
    
    public func disconnectDevice() -> Void {
        if connectedDevice != nil {
            centralManager.cancelPeripheralConnection(connectedDevice!)
            connectedDevice = nil
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.attemptDisconnect)
        }
    }
    
    // call this function to start scanning for BLE devices
    func startScanning() -> Void {
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.startedScanning)
    }
    
    public func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case CBCentralManagerState.PoweredOn:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("powered on"))
            startScanning()
            break
        case CBCentralManagerState.PoweredOff:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("powered off"))
            break
        case CBCentralManagerState.Resetting:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("resetting"))
            break
        case CBCentralManagerState.Unauthorized:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("unauthorized"))
            break
        case CBCentralManagerState.Unsupported:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("unsupported"))
            break
        case CBCentralManagerState.Unknown:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("unknown"))
            break
        }
    }
    
    public func centralManager(central: CBCentralManager, willRestoreState dict: [String : AnyObject]) {
        
    }
    
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        connectedDevice = peripheral
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didConnect)
        peripheral.delegate = self
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.setDelegateSelf)
        peripheral.discoverServices(nil);
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoverServices)
    }
    
    public func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        if error == nil {
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didFailConnect)
        } else {
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didFailConnect(error!))
        }
    }
    
    public func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        if error == nil {
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didDisconnect)
        } else {
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didDisconnect(error!))
        }
    }
    
    // saves a reference to the discovered peripherals and also saves the name for display
    public func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        if deviceList.containsObject(peripheral) {
            return
        }
        
        var deviceName = ""
        deviceList.addObject(peripheral)
        if (peripheral.name) != nil {
            
            deviceName = peripheral.name!
            deviceNameList.addObject(peripheral.name!)
        } else {
            
            deviceName = "Unknown Device"
            deviceNameList.addObject("Unknown Device")
        }
        
        delegate?.hasUpdate(self)
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.foundDevice(deviceName))
    }
    
    public func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        for services in peripheral.services! {
            if !discoveredServices.containsObject(services){
                discoveredServices.addObject(services)
                SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoveredService)
                peripheral.discoverCharacteristics(nil, forService: services)
                SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoverCharacteristics)
            }
        }
    }
    
    public func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoveredCharacteristic)
        for test in service.characteristics!{
            let test2 = test.isBroadcasted
            let test3 = test.isNotifying
            let test4 = test.properties
            let test5 = test.value
            peripheral.discoverDescriptorsForCharacteristic(test)
            peripheral.readValueForCharacteristic(test)
        }
    }
    
    public func peripheral(peripheral: CBPeripheral, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic, error: NSError?){
        print("descriptors = \(characteristic.descriptors)")
    }
    
    public func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("Value = \(characteristic.value)")
    }
}
