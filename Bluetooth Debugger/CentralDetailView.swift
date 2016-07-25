//
//  CentralDetailView.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/4/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit
import CoreBluetooth

class CentralDetailView: UIViewController, UITableViewDelegate, UITableViewDataSource, BLECentralControllerDelegate {

    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var deviceLabel: UILabel!
    
    var selectedIndex: Int? // index selected in previous view
    var expandedCells: NSMutableArray = []
    var centralReference: BLECentral = InstanceCache.sharedInstance.BLECentralInstance
    
    var discoveredServices: NSArray = []
    var discoveredCharacteristics: NSArray = []
    
    override func viewDidLoad() {
        centralReference.connectToDevice(selectedIndex!)
        self.deviceLabel.text = centralReference.deviceNameList[selectedIndex!] as? String
        self.infoTableView.separatorColor = UIColor.whiteColor()
        self.infoTableView.separatorInset = UIEdgeInsetsZero
        centralReference.detailDelegate = self
        let nib = UINib(nibName: "ExpandableCell", bundle: nil)
        infoTableView
            .registerNib(nib, forCellReuseIdentifier: "ExpandableCell_RID")
    }
    
    // MARK: UI Action Methods
    @IBAction func backButtonPressed(sender: AnyObject) {
        centralReference.disconnectDevice()
        self.willMoveToParentViewController(nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    // MARK: BluetoothCentral Delegate Methods
    func hasUpdateDetail(sender: BLECentral) {
        discoveredServices = (centralReference.discoveredServices)
        discoveredCharacteristics = (centralReference.discoveredCharacteristics)
        self.infoTableView.reloadData()
    }
    
    // MARK: TableView Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        while expandedCells.count < discoveredServices.count {
            expandedCells.addObject(NSMutableArray())
        }
        return discoveredServices.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if discoveredServices.count > section {
            let service = discoveredServices[section] as? CBService
            return "Service: \(service!.UUID)"
        } else {
            return ""
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 30))
        headerView.backgroundColor = UIColor(red:0.50, green:0.71, blue:0.98, alpha:1.0)
        self.tableView(tableView, titleForHeaderInSection: section)
        let titleLabel = UILabel(frame: CGRectMake(headerView.frame.origin.x + 10, headerView.frame.origin.y, headerView.frame.width - 10, headerView.frame.height))
        if discoveredServices.count > section {
            let service = discoveredServices[section] as? CBService
            titleLabel.text = "Service: \(HelperFunctions.getServiceUUIDType(service!))"
        } else {
            titleLabel.text = ""
        }
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayForService = discoveredCharacteristics[section] as! NSArray
        let expandedRowArray = expandedCells[section] as! NSMutableArray
        while expandedRowArray.count < arrayForService.count {
            expandedRowArray.addObject(false);
        }
        return arrayForService.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if expandedCells.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! Bool == true {
            return 252
        }
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.infoTableView.separatorColor = UIColor.whiteColor()
        self.infoTableView.separatorInset = UIEdgeInsetsZero
        let arrayForService = discoveredCharacteristics[indexPath.section] as! NSArray
        let cellCharacteristic = arrayForService[indexPath.row] as! CBCharacteristic
        
        if expandedCells.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! Bool == true {
            let cell:ExpandableCell = self.infoTableView.dequeueReusableCellWithIdentifier("ExpandableCell_RID") as! ExpandableCell
            let arrayForService = discoveredCharacteristics[indexPath.section] as! NSArray
            let cellCharacteristic = arrayForService[indexPath.row] as! CBCharacteristic
            cell.populateData(cellCharacteristic)
            return cell
        } else {
            let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
            cell.backgroundColor = UIColor(red:185/255.0, green:215/255.0, blue:255/255.0, alpha:1.0)
            cell.textLabel?.text = HelperFunctions.getCharUUIDType(cellCharacteristic)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let isExpanded = expandedCells.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! Bool
        expandedCells.objectAtIndex(indexPath.section).replaceObjectAtIndex(indexPath.row, withObject: !isExpanded)
        self.infoTableView.reloadData()
    }

}
