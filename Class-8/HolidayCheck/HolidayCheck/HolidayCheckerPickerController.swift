//
//  HolidayCheckerPickerViewController.swift
//  HolidayCheck
//
//  Created by Benjamin Sandofsky on 11/1/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

protocol HolidayCheckerPickerControllerDelegate:class {
    func checkerPickerController(controller: HolidayCheckerPickerController, didFinishPickingChecker checker:HolidayChecker)
    func didCancelCheckerPickerController(controller:HolidayCheckerPickerController)
}

private let CELL_IDENTIFIER = "com.codepath.holidaycheck.cellidentifier"

class HolidayCheckerPickerController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func didTapCancel(sender: AnyObject) {
        delegate?.didCancelCheckerPickerController(self)
    }

    weak var delegate:HolidayCheckerPickerControllerDelegate?
    var selectedChecker:HolidayChecker?
    var checkers:[HolidayChecker] = []

    class func checkerPickerViewControllerWithDelegate() -> HolidayCheckerPickerController {
        let controller = UIStoryboard(name: "HolidayCheckerPickerController", bundle: nil).instantiateInitialViewController() as! HolidayCheckerPickerController
        return controller
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER)!
        let checker = checkers[indexPath.row]
        cell.textLabel?.text = checker.localizedTitle
        if (selectedChecker == checker) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkers.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let checker = checkers[indexPath.row]
        delegate?.checkerPickerController(self, didFinishPickingChecker: checker)
    }
}
