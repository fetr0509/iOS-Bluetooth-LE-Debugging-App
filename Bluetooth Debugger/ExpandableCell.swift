//
//  ExpandableCell.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/14/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation
import UIKit

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
}
