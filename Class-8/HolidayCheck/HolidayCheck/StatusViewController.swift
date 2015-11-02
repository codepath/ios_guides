//
//  StatusViewController.swift
//  HolidayCheck
//
//  Created by Benjamin Sandofsky on 11/1/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController, HolidayCheckerPickerControllerDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateCheck()
    }

    @IBAction func didTapPicker(sender: AnyObject) {
        let picker = HolidayCheckerPickerController.checkerPickerViewControllerWithDelegate()
        picker.delegate = self
        picker.selectedChecker = HolidayPreferenceStore.sharedPreferences.currentChecker
        picker.checkers = [.Christmas, .NewYears]
        let nav = UINavigationController(rootViewController: picker)
        self.presentViewController(nav, animated: true, completion: nil)
    }

    func checkerPickerController(controller: HolidayCheckerPickerController, didFinishPickingChecker checker: HolidayChecker) {
        HolidayPreferenceStore.sharedPreferences.currentChecker = checker
        HolidayPreferenceStore.sharedPreferences.synchronize()
        self.checker = checker
        updateCheck()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func didCancelCheckerPickerController(controller: HolidayCheckerPickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    var checker:HolidayCheckable = HolidayPreferenceStore.sharedPreferences.currentChecker

    private func updateCheck(){
        self.title = checker.localizedTitle
        if let _ = checker.checkDateForHoliday(date) {
            self.statusLabel.text = "YES"
        } else {
            self.statusLabel.text = "NO"
        }
    }

    var date:NSDate {
        get {
            if let fakeDateString = NSProcessInfo.processInfo().environment["fakedate"] {
                let formatter = NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter.dateFromString(fakeDateString) ?? NSDate()
            } else {
                return NSDate()
            }
        }
    }
}
