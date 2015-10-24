//
//  ListViewController.swift
//  ViewControllerTransitionDemo
//
//  Created by Ben Sandofsky on 3/1/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UINavigationControllerDelegate {

    lazy var animator: MyCustomTransitionAnimator = MyCustomTransitionAnimator(transitioningController: self)

    enum CellIndexes:Int {
        case NormalTransition
        case InteractiveTransition
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.delegate = self
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let value = CellIndexes(rawValue: indexPath.row){
            switch value {
            case .NormalTransition:
                let detailsViewController = DetailViewController()
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            case .InteractiveTransition:
                let detailsViewController = DetailViewController()
                animator.applyInterationTransitionHook(detailsViewController)
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        } else {
            NSLog("Invalid index: \(indexPath.row)")
        }
    }

    // MARK: Navigation Controller Delegate
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }

    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animator.usingGesture {
            return animator
        } else {
            return nil
        }
    }
}

private let ANIMATION_DURATION = 0.35

// Fades in the new view
class MyCustomTransitionAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {

    unowned var transitioningController: UIViewController
    var usingGesture:Bool = false
    
    init(transitioningController: UIViewController){
        self.transitioningController = transitioningController
    }

    func applyInterationTransitionHook(controller: UIViewController){
        let panGesture = UIPanGestureRecognizer(target: self, action:"didPan:")
        controller.view.addGestureRecognizer(panGesture)
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return ANIMATION_DURATION
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        // Step 1: Add the view to the container view
        transitionContext.containerView().addSubview(toViewController.view)

        // Step 2: Apply your animation.
        toViewController.view.alpha = 0.0
        UIView.animateWithDuration(0.35, animations: {
            toViewController.view.alpha = 1.0
            }, completion: { (finished) in
                // Step 3: Call completion handler
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }

    // MARK: Interactive Transitions
    func didPan(gesture: UIPanGestureRecognizer){
        let point = gesture.locationInView(transitioningController.view)
        let percent = fmaxf(fminf(Float(point.x / 300.0), 0.99), 0.0)
        switch (gesture.state){
        case .Began:
            self.usingGesture = true
            self.transitioningController.navigationController?.popViewControllerAnimated(true)
        case .Changed:
            self.updateInteractiveTransition(CGFloat(percent))
        case .Ended, .Cancelled:
            if percent > 0.5 {
                self.finishInteractiveTransition()
            } else {
                self.cancelInteractiveTransition()
            }
            self.usingGesture = false
        default:
            NSLog("Unhandled state")
        }
    }
    
}