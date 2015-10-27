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
    private func finish(){
        delegate?.didCompleteGlobalSettingsController(self)
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        finish()
    }
    @IBAction func tappedReset(sender: AnyObject) {
        finish()
        SizeClassHack.sharedSizedClassHack.resetToDefaultSizeClass()
    }
    @IBAction func tappedRegularRegular(sender: AnyObject) {
        finish()
        SizeClassHack.sharedSizedClassHack.updateSizeClassForHorizontal(.Regular, andVertical: .Regular)
    }
    @IBAction func tappedRegularCompact(sender: AnyObject) {
        finish()
        SizeClassHack.sharedSizedClassHack.updateSizeClassForHorizontal(.Regular, andVertical: .Compact)
    }
    
    @IBAction func tappedCompactRegular(sender: AnyObject) {
        finish()
        SizeClassHack.sharedSizedClassHack.updateSizeClassForHorizontal(.Compact, andVertical: .Regular)
    }

    @IBAction func tappedCompactCompact(sender: AnyObject) {
        finish()
        SizeClassHack.sharedSizedClassHack.updateSizeClassForHorizontal(.Compact, andVertical: .Compact)
    }
}
