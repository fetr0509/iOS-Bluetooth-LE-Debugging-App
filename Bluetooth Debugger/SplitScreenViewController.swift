//
//  SplitScreenViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/18/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit

class SplitScreenViewController: UIViewController, UIPopoverPresentationControllerDelegate,  BLECentralControllerDelegate {

    @IBOutlet weak var viewTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var buttonTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tabbar: UITabBar!
    
    var debuggerVisible = true
    var BLEInstance = InstanceCache.sharedInstance.BLECentralInstance
    
    var offWarningView: UIView?
    var frostView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(tabbar)
        BLEInstance.statusDelegate = self
        
        offWarningView = (NSBundle.mainBundle().loadNibNamed("BLEOffWarningView", owner: nil, options: nil).first as? UIView)!
        let width: CGFloat = 300.0
        let height: CGFloat = 400.0
        offWarningView!.frame = CGRectMake(self.view.frame.width/2 - width/2,self.view.frame.height/8, width, height)
        
        frostView = UIView(frame: self.view.frame)
        frostView!.backgroundColor = UIColor.grayColor()
        frostView!.alpha = 0.8
    }

    // Toggle value to know when top view is visible (for animating)
    func setDebuggerVisible() -> Void {
        self.debuggerVisible = !debuggerVisible
    }
    
    // determines when bluetooth is enabled or not
    func statusChanged(sender: BLECentral, on: Bool) {
        if on == false {
            self.view.addSubview(frostView!)
            self.view.addSubview(offWarningView!)
        }
        else {
            self.frostView!.removeFromSuperview()
           // self.offWarningView!.removeFromSuperview()
            self.view.layoutSubviews()
        }
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
