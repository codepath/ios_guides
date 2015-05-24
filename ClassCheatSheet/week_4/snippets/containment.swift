var activeViewController: UIViewController? {
    didSet(oldViewControllerOrNil){
        if let oldVC = oldViewControllerOrNil {
            oldVC.willMoveToParentViewController(nil)
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParentViewController()
        }
        if let newVC = activeViewController {
            self.addChildViewController(newVC)
            newVC.view.frame = self.contentView.bounds
            self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
        }
    }
}