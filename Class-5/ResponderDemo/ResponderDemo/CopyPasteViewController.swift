//
//  CopyPasteViewController.swift
//  ResponderDemo
//
//  Created by Benjamin Sandofsky on 5/31/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class CopyPasteViewController: UIViewController {
    
    @IBOutlet weak var exampleView: MyCustomView!

    @IBAction func showMenu(sender: AnyObject) {
        NSLog("Show menu")
        exampleView.becomeFirstResponder()
        UIMenuController.sharedMenuController().setTargetRect(self.exampleView.frame, inView: self.exampleView.superview!)
        UIMenuController.sharedMenuController().setMenuVisible(true, animated: true)
    }

}

class MyCustomView: UIView {

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func copy(sender: AnyObject?) {
        let pasteBoard = UIPasteboard.generalPasteboard()
        pasteBoard.string = "You copied some text"
    }
}