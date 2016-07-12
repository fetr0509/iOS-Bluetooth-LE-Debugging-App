//
//  DebuggerTextHandler.swift
//  Bluetooth Debugger
//
//  Created by Peter Fetros on 7/2/16.
//  Copyright © 2016 Peter Fetros. All rights reserved.
//

import Foundation

protocol DebuggerTextHandlerDelegate: class {
    func hasUpdate(textToDisplay: String)
}

class DebuggerTextHandler {
    
    weak var delegate:DebuggerTextHandlerDelegate?
    
    private var newTextQueue: NSMutableArray = NSMutableArray()
    
    func addDebuggerString(newString: String) -> Void {
        if newTextQueue.count >= 500 {
            newTextQueue.removeObjectAtIndex(0)
        }
        let timeTag = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle)
        newTextQueue.addObject(timeTag + ": " + newString + "\n")
        
        self.madeChange()
    }
    
    func clearDebuggerString() -> Void {
        newTextQueue.removeAllObjects()
        madeChange()
    }
    
    private func madeChange(){
        var debuggerString: String = ""
        for string in newTextQueue {
            debuggerString = debuggerString.stringByAppendingString(string as! String)
        }
        delegate?.hasUpdate(debuggerString)
    }
}