//
//  RootViewController.swift
//  FontBrowserDemo
//
//  Created by Ben Sandofsky on 10/25/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.definesPresentationContext = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sizeClassHackDidUpdate:", name: SizeClassHackDidUpdateNotification, object: nil)
    }
    var childSplitViewController:UISplitViewController! {
        get {
            self.loadViewIfNeeded()
            return self.childViewControllers.first! as! UISplitViewController
        }
    }
    func sizeClassHackDidUpdate(notification:NSNotification){
        self.setOverrideTraitCollection(SizeClassHack.sharedSizedClassHack.overrideTraits, forChildViewController: childSplitViewController)
    }
}

private var _sharedSizedClassHack = SizeClassHack()

struct SizeClassOverride {
    let horizontal:UIUserInterfaceSizeClass
    let vertical:UIUserInterfaceSizeClass
}

let SizeClassHackDidUpdateNotification = "SizeClassHackDidUpdateNotification"

class SizeClassHack {
    var sizeClassOverride:SizeClassOverride? {
        didSet {
            postNotification()
        }
    }

    var overrideTraits:UITraitCollection? {
        get {
            if let override = sizeClassOverride {
                return UITraitCollection(traitsFromCollections: [UITraitCollection(horizontalSizeClass: override.horizontal), UITraitCollection(verticalSizeClass: override.vertical)])
            } else {
                return nil
            }
        }
    }

    class var sharedSizedClassHack:SizeClassHack {
        return _sharedSizedClassHack
    }

    func resetToDefaultSizeClass(){
        sizeClassOverride = nil
    }

    func updateSizeClassForHorizontal(horizontal:UIUserInterfaceSizeClass, andVertical vertical:UIUserInterfaceSizeClass){
        sizeClassOverride = SizeClassOverride(horizontal: horizontal, vertical: vertical)
        
    }
    private func postNotification(){
        NSNotificationCenter.defaultCenter().postNotificationName(SizeClassHackDidUpdateNotification, object: nil)
    }
}