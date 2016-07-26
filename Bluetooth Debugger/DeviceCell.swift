//
//  DeviceCell.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/26/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit
import CoreBluetooth

class DeviceCell: UITableViewCell {
    
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var decibelLevel: UILabel!
    @IBOutlet weak var decibelImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
