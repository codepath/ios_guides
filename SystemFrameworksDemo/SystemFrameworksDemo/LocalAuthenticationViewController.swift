//
//  LocalAuthenticationViewController.swift
//  SystemFrameworksDemo
//
//  Created by Ben Sandofsky on 10/15/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit
import LocalAuthentication

class LocalAuthenticationViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    @IBAction func tappedAuthenticate(sender: AnyObject) {
        let context = LAContext()
        var errorOrNil:NSError? = nil
        context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &errorOrNil)
        if let _ = errorOrNil {
            self.label.text = NSLocalizedString("Touch ID Unavailable.", comment:"")
            return
        }
        context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: NSLocalizedString("Demo reasons.", comment:""), reply: { (success, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    self.label.text = "Success!"
                } else {
                    self.label.text = "Failed: \(error)"
                }
            }
        })
    }
}
