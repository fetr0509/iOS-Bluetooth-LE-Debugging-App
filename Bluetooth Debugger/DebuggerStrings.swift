//
//  DebuggerStrings.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/2/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation

class DebuggerStrings {
    
    static let startedScanning = "Central has started scanning for BLE devices"
    static let stoppedScanning = "Central has stopped scanning for BLE devices"
    static let didConnect = "connected successfully"
    static let didDisconnect = "disconnected successfully"
    static let didFailConnect = "failed to connect"
    static let setDelegateSelf = "Central has set itslef as peripheral delegate"
    static let discoverServices = "Attempting to discover peripheral services"
    static let discoveredService = "discovered new service for peripheral"
    static let discoverCharacteristics = "Attempting to discover characteristic for service"
    static let discoveredCharacteristic = "discovered new characteristic for service"
    static let attemptDisconnect = "Central is attempting to disconnect to device"
    
    static func peripheralChangedState(state: String) -> String {
        return "Peripheral has changed state to \(state)"
    }
    
    
    static func centralChangedState(state: String) -> String {
        return "Central has changed state to \(state)"
    }
    
    static func foundDevice(name: String) -> String {
        return "Central has discovered the device: \(name)"
    }
    
    static func attemptConnect(name: String) -> String {
        return "Central is attempting to connect to device: \(name)"
    }
    
    static func didDisconnect(error: NSError) -> String {
        return "Central disconnected with the reason: \(error.localizedDescription)"
    }
    
    static func didFailConnect(error: NSError) -> String {
        return "Central failed to connect with the reason: \(error.localizedDescription)"
    }
}
