//
//  Christmas.swift
//  HolidayCheck
//
//  Created by Benjamin Sandofsky on 11/1/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import Foundation

struct ChristmasChecker:HolidayChecker {
    func checkDateForHoliday(date: NSDate) -> Holiday? {
        let components = NSCalendar.currentCalendar().components(
            [NSCalendarUnit.Day, NSCalendarUnit.Month], fromDate: date)
        if components.day == 25 && components.month == 12 {
            return Christmas()
        } else {
            return nil
        }
    }
}