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