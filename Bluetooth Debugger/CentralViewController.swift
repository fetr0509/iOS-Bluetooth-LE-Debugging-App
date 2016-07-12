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
    
    var central = BLECentral()
    var deviceNameList: NSMutableArray = []
    
    @IBOutlet weak var searchingLabel: UILabel!
    @IBOutlet weak var deviceTableView: UITableView!
    
    override func viewDidLoad() {
        central.delegate = self
    }
    
    func hasUpdate(sender: BLECentral){
        self.deviceNameList = central.deviceNameList
        deviceTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let centralDetailView = CentralDetailView()
        centralDetailView.selectedIndex = indexPath.row
        centralDetailView.centralReference = central
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        
        let deviceName: String = deviceNameList.objectAtIndex(indexPath.row) as! String
        cell.textLabel?.text = deviceName
        return cell
    }
}
