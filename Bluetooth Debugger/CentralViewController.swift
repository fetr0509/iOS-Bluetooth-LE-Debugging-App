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
    var BluetoothisOn: Bool = true
    
    @IBOutlet weak var searchingLabel: UILabel!
    @IBOutlet weak var deviceTableView: UITableView!
    
    override func viewDidLoad() {
        central.mainDelegate = self
        self.deviceTableView.separatorColor = UIColor.whiteColor()
        self.deviceTableView.separatorInset = UIEdgeInsetsZero
    }
    
    // MARK: BluetoothCentral Delegate Methods
    func hasUpdateDevice(sender: BLECentral){
        self.deviceNameList = central.deviceNameList
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
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor(red:185/255.0, green:215/255.0, blue:255/255.0, alpha:1.0)
        let deviceName: String = deviceNameList.objectAtIndex(indexPath.row) as! String
        cell.textLabel?.text = deviceName
        return cell
    }
}
