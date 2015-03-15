//
//  LeakyViewController.swift
//  PerformanceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class LeakyViewController: UIViewController {
    var leakyObject:LeakyObject = LeakyObject()

    @IBOutlet weak var keyboardStateLabel: UILabel!
    var keyboardObserverOrNil:AnyObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardStateLabel.hidden = true
        keyboardObserverOrNil = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()){ notification in
            self.keyboardStateLabel.hidden = false
        }
    }

    deinit {
        if let keyboardObserver:AnyObject = keyboardObserverOrNil {
            NSNotificationCenter.defaultCenter().removeObserver(keyboardObserver)
        }
        NSLog("View controller deinitialized")
    }
}

class LeakyObject {
    var leakyChild:LeakyChild!

    init() {
        self.leakyChild = LeakyChild(parent: self)
    }
    deinit{
        NSLog("Successfully deinitialize")
    }
}

class LeakyChild {
    var parent:LeakyObject
    init(parent:LeakyObject){
        self.parent = parent
    }
}