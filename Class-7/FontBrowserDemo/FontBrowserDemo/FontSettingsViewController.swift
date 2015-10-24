//
//  FontSettingsViewController.swift
//  FontBrowserDemo
//
//  Created by Benjamin Sandofsky on 10/24/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

protocol FontSettingsViewControllerDelegate:class {
    func fontSettingsViewController(controller:FontSettingsViewController, didChangeSizeToSize fontSize:CGFloat) -> ()
}

class FontSettingsViewController: UIViewController {
    class func fontSettingsController() -> FontSettingsViewController {
        let storyboard = UIStoryboard(name: "FontSettingsViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! FontSettingsViewController
    }
    weak var delegate:FontSettingsViewControllerDelegate?
    @IBOutlet weak var sizeSlider: UISlider!
    
    @IBAction func sizeSliderDidChange(sender: UISlider) {
        delegate?.fontSettingsViewController(self, didChangeSizeToSize: CGFloat(sender.value))
    }
}
