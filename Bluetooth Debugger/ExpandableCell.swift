//
//  ExpandableCell.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/14/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit
import CoreBluetooth

class ExpandableCell: UITableViewCell {
    
    @IBOutlet weak var UUIDLabel: UILabel!
    
    @IBOutlet weak var characteristicValue: UILabel!
    @IBOutlet weak var isNotifyingLabel: UILabel!

    @IBOutlet weak var propertiesLabel: UILabel!
    @IBOutlet weak var descriptorTextView: UITextView!
    @IBOutlet weak var expandImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func populateData(characteristic: CBCharacteristic) -> Void {
        self.descriptorTextView.layer.borderWidth = 1.0
        self.descriptorTextView.layer.borderColor = UIColor.blackColor().CGColor
        self.selectionStyle = .None
        
        self.UUIDLabel.text = HelperFunctions.getCharUUIDType(characteristic)
        self.characteristicValue.text = HelperFunctions.decodeNSData(characteristic.value)
        self.isNotifyingLabel.text = "\(characteristic.isNotifying)"
        self.propertiesLabel.text = HelperFunctions.getPropertiesDescription(characteristic.properties)
        var descriptorString: String = ""
        if characteristic.descriptors != nil {
            for descriptor in characteristic.descriptors! {
                descriptorString = descriptorString.stringByAppendingString("UUID: \(descriptor.UUID)\n")
                descriptorString = descriptorString.stringByAppendingString("Value: \(descriptor.value)\n")
            }
        }
        self.descriptorTextView.text = descriptorString
    }
}
