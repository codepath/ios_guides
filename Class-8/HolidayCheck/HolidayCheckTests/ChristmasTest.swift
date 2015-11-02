//
//  ChristmasTest.swift
//  HolidayCheck
//
//  Created by Benjamin Sandofsky on 11/1/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import XCTest

@testable import HolidayCheck

class ChristmasTests: XCTestCase {
    var christmas:HolidayCheckable = HolidayChecker.Christmas
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func dateFromMonth(monthOrNil:Int?, dayOrNil:Int?, yearOrNil:Int?) -> NSDate {
        let components = NSDateComponents()
        if let month = monthOrNil {
            components.month = month
        }
        if let year = yearOrNil {
            components.year = year
        }
        if let day = dayOrNil {
            components.day = day
        }
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func testShouldBePositiveForChristmas(){
        let christmasDate = dateFromMonth(12, dayOrNil: 25, yearOrNil: 2015)
        let holiday = HolidayChecker.Christmas.checkDateForHoliday(christmasDate)
        XCTAssertNotNil(holiday)
    }

    func testShouldFailForNewYears(){
        let newYears = dateFromMonth    (1, dayOrNil: 1, yearOrNil: 2016)
        XCTAssertNil(HolidayChecker.Christmas.checkDateForHoliday(newYears))
    }
}
