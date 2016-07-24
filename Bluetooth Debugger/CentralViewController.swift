//
//  CentralViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/19/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit
import CoreBluetooth

class CentralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, BLECentralControllerDelegate {
    
    var central = BLECentral()
    var deviceNameList: NSMutableArray = []
    var BluetoothisOn: Bool = true
    var offWarningView: OffWarningView = OffWarningView()
    
    @IBOutlet weak var searchingLabel: UILabel!
    @IBOutlet weak var deviceTableView: UITableView!
    
    override func viewDidLoad() {
        central.mainDelegate = self
        self.deviceTableView.separatorColor = UIColor.whiteColor()
        self.deviceTableView.separatorInset = UIEdgeInsetsZero
        
        offWarningView.view.frame = CGRectMake(0, 0, 300, 400)
        offWarningView.preferredContentSize = CGSize(width: 300, height: 400)
        self.offWarningView.modalPresentationStyle = .Popover
        offWarningView.popoverPresentationController!.delegate = self
    }
    
    // MARK: BluetoothCentral Delegate Methods
    func hasUpdateDevice(sender: BLECentral){
        self.deviceNameList = central.deviceNameList
        deviceTableView.reloadData()
    }
    
    func statusChanged(sender: BLECentral, on: Bool){
        if on == false {
            
            presentViewController(offWarningView, animated: true, completion: nil)
            let popoverPresentationController = offWarningView.popoverPresentationController
            popoverPresentationController?.sourceView = self.view
            popoverPresentationController?.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 0, 0)
            popoverPresentationController?.delegate = self
        }
        else {
            if BluetoothisOn == false {
                
            }
        }
    }
    
    // MARK: TableView Delegate Methods
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
        self.deviceTableView.separatorColor = UIColor.whiteColor()
        self.deviceTableView.separatorInset = UIEdgeInsetsZero
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor(red:185/255.0, green:215/255.0, blue:255/255.0, alpha:1.0)
        let deviceName: String = deviceNameList.objectAtIndex(indexPath.row) as! String
        cell.textLabel?.text = deviceName
        return cell
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
