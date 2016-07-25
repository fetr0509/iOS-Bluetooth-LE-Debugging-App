//
//  BLECentral.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/20/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation
import CoreBluetooth


// These delegate protocols allow the Main Central View and Detail View to know
// When an update is available for their respective tableviews
@objc protocol BLECentralControllerDelegate: class {
    optional func hasUpdateDevice(sender: BLECentral)
    optional func hasUpdateDetail(sender: BLECentral)
    optional func statusChanged(sender: BLECentral, on: Bool)
}

public class BLECentral: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate  {
    
    var deviceList: NSMutableArray = [] // list of discovered devices
    var deviceNameList: NSMutableArray = [] // list of discovered device names (for tableview)
    var discoveredServices: NSMutableArray = [] // list of discovered services
    var discoveredCharacteristics: NSMutableArray = []
    var centralManager: CBCentralManager!
    var connectedDevice: CBPeripheral? = nil // set when device is succefully connected to
    
    weak var mainDelegate :BLECentralControllerDelegate?
    weak var detailDelegate :BLECentralControllerDelegate?
    weak var statusDelegate :BLECentralControllerDelegate?
    
    override init(){
        super.init()
        // initialize the Central Manager
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue(), options: [CBCentralManagerOptionShowPowerAlertKey:false])
    }
    
    // Get the actual device using the index selected in the TableView
    public func getDevice(index: Int) -> CBPeripheral? {
        if deviceList.count > index {
            return (deviceList[index] as! CBPeripheral)
        } else {
            return nil
        }
    }
    
    // Helper function for connecting to device
    public func connectToDevice(index: Int) -> Void {
        let device = deviceList[index] as! CBPeripheral
        centralManager.connectPeripheral(device, options: nil)
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.attemptConnect(deviceNameList[index] as! String))
        
    }
    
    // Helper function for disconnecting to device
    public func disconnectDevice() -> Void {
        if connectedDevice != nil {
            centralManager.cancelPeripheralConnection(connectedDevice!)
            connectedDevice = nil
            discoveredServices.removeAllObjects()
            discoveredCharacteristics.removeAllObjects()
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.attemptDisconnect)
        }
    }
    
    // call this function to start scanning for BLE devices
    func startScanning() -> Void {
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.startedScanning)
    }
    
    // MARK: Delegate Methods
    
    // Called when the hardware state is updated.
    public func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case CBCentralManagerState.PoweredOn:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("powered on"))
            statusDelegate!.statusChanged!(self, on: true)
            startScanning()
            break
        case CBCentralManagerState.PoweredOff:
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.centralChangedState("powered off"))
            if mainDelegate != nil {
                statusDelegate!.statusChanged!(self, on: false)
            }
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
    
    // Not used yet
    public func centralManager(central: CBCentralManager, willRestoreState dict: [String : AnyObject]) {
        
    }
    
    // Called when successfully connected to a device
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        connectedDevice = peripheral
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didConnect)
        peripheral.delegate = self
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.setDelegateSelf)
        peripheral.discoverServices(nil);
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoverServices)
    }
    
    // called when the connection failed, if there is an error it is displayed
    public func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        if error == nil {
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didFailConnect)
        } else {
            SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.didFailConnect(error!))
        }
    }
    
    // Successfully disconnected from Peripheral, displays error if it was not intentional
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
        
        mainDelegate?.hasUpdateDevice!(self)
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.foundDevice(deviceName))
    }
    
    // Called when a service is dicovered for connected peripheral
    public func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        for service in peripheral.services! {
            if !discoveredServices.containsObject(service){
                discoveredServices.addObject(service)
                discoveredCharacteristics.addObject(NSMutableArray())
                
                SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoveredService)
                
                peripheral.discoverCharacteristics(nil, forService: service)
                SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoverCharacteristics)
            }
        }
    }
    
    // Called when a Characterisic is discovered for peripheral
    public func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        let characteristicArrayIndex = discoveredServices.indexOfObject(service)
        let charactersiticArray = discoveredCharacteristics[characteristicArrayIndex] as! NSMutableArray
        
        for characteristic in service.characteristics! {
            if !charactersiticArray.containsObject(characteristic) {
                charactersiticArray.addObject(characteristic)
                SharedDebuggerInstance.sharedInstance.debuggerTextHandler.addDebuggerString(DebuggerStrings.discoveredCharacteristic)
                
                peripheral.discoverDescriptorsForCharacteristic(characteristic )
                peripheral.readValueForCharacteristic(characteristic )
            }
        }
        if detailDelegate != nil {
            self.detailDelegate?.hasUpdateDetail!(self)
        }
    }
    
    // called when a Descriptor is discovered relating to a service
    public func peripheral(peripheral: CBPeripheral, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic, error: NSError?){
        if detailDelegate != nil {
            self.detailDelegate?.hasUpdateDetail!(self)
        }
    }
    
    // called when the value for a characteristic is updated
    public func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if detailDelegate != nil {
            self.detailDelegate?.hasUpdateDetail!(self)
        }
    }
}
