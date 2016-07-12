//
//  CentralDetailView.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/4/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit
import CoreBluetooth

class CentralDetailView: UIViewController {

    @IBOutlet weak var deviceLabel: UILabel!
    var selectedIndex: Int?
    var centralReference: BLECentral?
    
    override func viewDidLoad() {
        centralReference?.connectToDevice(selectedIndex!)
        self.deviceLabel.text = centralReference?.deviceNameList[selectedIndex!] as? String
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        centralReference?.disconnectDevice()
        self.willMoveToParentViewController(nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
