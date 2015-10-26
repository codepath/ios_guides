//
//  VerticalSplitViewController.swift
//  FlashCard
//
//  Created by Benjamin Sandofsky on 10/25/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class VerticalSplitViewController: UIViewController {
    @IBOutlet weak var primaryContainerView: UIView!
    @IBOutlet weak var secondaryContainerView: UIView!

    var primaryController:UIViewController?
    var secondController:UIViewController?

    private func updateViewController(inout existingControllerOrNil:UIViewController?, inContainer container:UIView, newController newControllerOrNil:UIViewController?){
        if let oldController = existingControllerOrNil {
            oldController.willMoveToParentViewController(nil)
            oldController.view.removeFromSuperview()
            oldController.removeFromParentViewController()
        }
        if let newController = newControllerOrNil {
            newController.view.frame = self.primaryContainerView.bounds
            newController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.addChildViewController(newController)
            container.addSubview(newController.view)
            newController.didMoveToParentViewController(self)
        }
        existingControllerOrNil = newControllerOrNil
    }

    override func showDetailViewController(vc: UIViewController, sender: AnyObject?) {
        NSLog("Called override method")
        updateViewController(&secondController, inContainer: secondaryContainerView, newController: vc)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let questionViewController = QuestionViewController.questionViewController()
        updateViewController(&primaryController, inContainer: primaryContainerView, newController: questionViewController)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
