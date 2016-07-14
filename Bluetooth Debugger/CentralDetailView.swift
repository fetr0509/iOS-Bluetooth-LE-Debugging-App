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
    
    var selectedIndex: Int?
    var centralReference: BLECentral?
    
    override func viewDidLoad() {
        centralReference?.connectToDevice(selectedIndex!)
        self.deviceLabel.text = centralReference?.deviceNameList[selectedIndex!] as? String
        self.infoTableView.separatorColor = UIColor.clearColor()
        centralReference?.detailDelegate = self
    }
    
    
    // MARK: UI Action Methods
    @IBAction func backButtonPressed(sender: AnyObject) {
        centralReference?.disconnectDevice()
        self.willMoveToParentViewController(nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    // MARK: BluetoothCentral Delegate Methods
    func hasUpdateDetail(sender: BLECentral) {
        
    }
    
    // MARK: TableView Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.infoTableView.separatorColor = UIColor.clearColor()
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.selectionStyle = .None

        
        return cell
    }

}
