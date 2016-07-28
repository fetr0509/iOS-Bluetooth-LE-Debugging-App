//
//  CentralViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/19/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit
import CoreBluetooth

class CentralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BLECentralControllerDelegate {
    
    var central = InstanceCache.sharedInstance.BLECentralInstance
    var deviceNameList: NSMutableArray = []
    var deviceRSSIList: NSMutableArray = []
    var BluetoothisOn: Bool = true
    
    @IBOutlet weak var searchingLabel: UILabel!
    @IBOutlet weak var deviceTableView: UITableView!
    
    override func viewDidLoad() {
        central.mainDelegate = self
        self.deviceTableView.separatorColor = UIColor.whiteColor()
        self.deviceTableView.separatorInset = UIEdgeInsetsZero
        let nib = UINib(nibName: "DeviceCell", bundle: nil)
        deviceTableView.registerNib(nib, forCellReuseIdentifier: "DeviceCell_RID")
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.animateLabel), userInfo: nil, repeats: true)
    }
    
    func animateLabel(){
        switch searchingLabel.text! {
        case "Searching for Devices":
            searchingLabel.text = "Searching for Devices."
            break
        case "Searching for Devices.":
            searchingLabel.text = "Searching for Devices.."
            break
        case "Searching for Devices..":
            searchingLabel.text = "Searching for Devices..."
            break
        case "Searching for Devices...":
            searchingLabel.text = "Searching for Devices"
            break
        default:
            "Searching for Devices"
        }
        
    }
    // MARK: BluetoothCentral Delegate Methods
    func hasUpdateDevice(sender: BLECentral){
        self.deviceNameList = central.deviceNameList
        self.deviceRSSIList = central.deviceRSSIList
        deviceTableView.reloadData()
    }
    
    // MARK: TableView Delegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let centralDetailView = CentralDetailView()
        centralDetailView.selectedIndex = indexPath.row
        centralDetailView.view.frame = self.view.frame
        
        self.view.addSubview(centralDetailView.view)
        addChildViewController(centralDetailView)
        centralDetailView.didMoveToParentViewController(self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceNameList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.deviceTableView.separatorColor = UIColor.whiteColor()
        self.deviceTableView.separatorInset = UIEdgeInsetsZero
        
        let cell = self.deviceTableView.dequeueReusableCellWithIdentifier("DeviceCell_RID") as! DeviceCell
        
        let deviceName: String = deviceNameList.objectAtIndex(indexPath.row) as! String
        cell.deviceName.text = deviceName
        let level = deviceRSSIList.objectAtIndex(indexPath.row)
        if level.intValue == 0 {
            cell.decibelLevel.text = "---"
        } else {
            cell.decibelLevel.text = "\(deviceRSSIList.objectAtIndex(indexPath.row))"
        }
        return cell
    }
}
