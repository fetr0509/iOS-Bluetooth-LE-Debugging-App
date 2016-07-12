//
//  SplitScreenViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/18/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit

class SplitScreenViewController: UIViewController {

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
    
    
    @IBAction func toggleDebuggerView(sender: AnyObject) {
        if debuggerVisible {
            UIView.animateWithDuration(0.5, animations: {
                
                self.topView.frame = CGRectMake(0, -self.topView.frame.size.height+20, self.topView.frame.size.width, self.topView.frame.size.height)
                
                self.toggleButton.frame = CGRectMake(0, 20, self.toggleButton.frame.size.width, self.toggleButton.frame.size.height)
                
                let newOriginY = self.toggleButton.frame.size.height + self.toggleButton.frame.origin.y
                let newHeight = self.tabbar.frame.origin.y - newOriginY
                self.bottomView.frame = CGRectMake(0, newOriginY, self.toggleButton.frame.size.width, newHeight)
                
                
                }, completion: {(Bool) in self.setScreenVisible()})
        } else {
            UIView.animateWithDuration(0.5, animations: {
                
                self.topView.frame = CGRectMake(0, 20, self.topView.frame.size.width, self.topView.frame.size.height)
                
                self.toggleButton.frame = CGRectMake(0, self.topView.frame.origin.y + self.topView.frame.size.height, self.toggleButton.frame.size.width, self.toggleButton.frame.size.height)
                
                let newOrigin = self.toggleButton.frame.origin.y + self.toggleButton.frame.size.height
                let newHeight = self.view.frame.size.height - newOrigin - self.tabbar.frame.size.height
                
                self.bottomView.frame = CGRectMake(0, newOrigin, self.toggleButton.frame.size.width, newHeight)
                
                }, completion: {(Bool) in self.setScreenVisible()})
        }
    }
    
    func setScreenVisible() -> Void {
        self.debuggerVisible = !debuggerVisible
    }

}
