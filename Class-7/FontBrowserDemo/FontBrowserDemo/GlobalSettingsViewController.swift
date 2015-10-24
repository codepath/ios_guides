//
//  GlobalSettingsViewController.swift
//  FontBrowserDemo
//
//  Created by Benjamin Sandofsky on 10/24/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

protocol GlobalSettingsViewControllerDelegate:class {
    func didCompleteGlobalSettingsController(controller:GlobalSettingsViewController)
}

class GlobalSettingsViewController: UIViewController {
    weak var delegate:GlobalSettingsViewControllerDelegate?
    
    @IBAction func didTapDone(sender: AnyObject) {
        delegate?.didCompleteGlobalSettingsController(self)
    }
}
