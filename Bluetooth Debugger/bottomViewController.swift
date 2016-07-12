//
//  bottomViewController.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 6/19/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import UIKit

class bottomViewController: UIViewController {

    var centralView = CentralViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralView.view.frame = self.view.bounds
        self.view.addSubview(centralView.view)
        addChildViewController(centralView)
        centralView.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
