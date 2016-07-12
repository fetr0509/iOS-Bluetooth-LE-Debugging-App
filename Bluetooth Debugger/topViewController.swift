//
//  topViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/2/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit

class topViewController: UIViewController, DebuggerTextHandlerDelegate {
    
    @IBOutlet weak var DebuggerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hasUpdate(textToDisplay: String) {
        DebuggerTextView.text = textToDisplay as String
    }
    
    @IBAction func clearDebuggingInfo(sender: AnyObject) {
        SharedDebuggerInstance.sharedInstance.debuggerTextHandler.clearDebuggerString()
    }
}
