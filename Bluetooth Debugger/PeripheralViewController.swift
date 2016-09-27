//
//  PeripheralView.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/20/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit

class PeripheralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var peripheralTableView: UITableView!
    override func viewDidLoad() {
        
    }
    
    @IBAction func createNewPeripheral(sender: AnyObject) {
    }
        // MARK: TableView Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
