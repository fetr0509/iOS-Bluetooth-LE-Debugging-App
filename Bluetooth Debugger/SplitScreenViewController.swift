//
//  SplitScreenViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/18/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit

class SplitScreenViewController: UIViewController {

    @IBOutlet weak var viewTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var buttonTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tabbar: UITabBar!
    
    var debuggerVisible = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(tabbar)
        // Do any additional setup after loading the view.
    }

    // Toggle value to know when top view is visible (for animating)
    func setDebuggerVisible() -> Void {
        self.debuggerVisible = !debuggerVisible
    }
    
    @IBAction func toggleDebuggerView(sender: AnyObject) {
        
        if debuggerVisible {
            self.toggleButton.setImage(UIImage(named: "DownArrow"), forState: .Normal)
            UIView.animateWithDuration(0.5, animations: {
                self.bottomViewHeightCons.constant += self.topView.frame.size.height
                self.viewTopConstrain.constant = -self.topView.frame.height
                self.view.layoutIfNeeded()
                }, completion: {(finished: Bool) in self.setDebuggerVisible()})
        } else {
            toggleButton.setImage(UIImage(named: "UpArrow"), forState: .Normal)
            UIView.animateWithDuration(0.5, animations: {
                self.bottomViewHeightCons.constant -= self.topView.frame.size.height
                self.viewTopConstrain.constant = 0
                self.view.layoutIfNeeded()
                }, completion: {(Bool) in self.setDebuggerVisible()})
        }
    }
}
