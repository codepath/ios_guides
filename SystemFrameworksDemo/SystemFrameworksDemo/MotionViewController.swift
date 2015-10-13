//
//  MotionViewController.swift
//  SystemFrameworksDemo
//
//  Created by Ben Sandofsky on 10/15/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit
import CoreMotion

class MotionViewController: UIViewController {
    lazy var motionManager:CMMotionManager = CMMotionManager()

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (accelerometerData, error) in
            let a = accelerometerData!.acceleration
            let sum = (a.x * a.x) + (a.y * a.y) + (a.z * a.z)
            let w = self.view.bounds.size.width
            self.widthConstraint.constant = w - (w * CGFloat(sum / 3.0))
            NSLog("Data: \(sqrt(sum))")
            return ()
        })
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.motionManager.stopAccelerometerUpdates()
    }
}
