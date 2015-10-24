//
//  SawToothViewController.swift
//  PerformanceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

let ITERATIONS = 100

class SawToothViewController: UIViewController {

    
    @IBOutlet weak var progressLabel: UILabel!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            for var i = 0; i < ITERATIONS; i++ {
                for var j = 0; j < 10000; j++ {
                    let myString:NSString = "i:\(i)/ j:\(j)" as NSString
                    let myUppercaseString = myString.uppercaseString
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.progressLabel.text = "\((Float(i) / Float(ITERATIONS)) * 100)%"
                }
            }
        }
    }
}
