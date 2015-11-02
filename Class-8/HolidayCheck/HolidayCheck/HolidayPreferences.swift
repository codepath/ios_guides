//
//  HolidayPreferences.swift
//  HolidayCheck
//
//  Created by Benjamin Sandofsky on 11/1/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

enum HolidayPreferencesKeys:String {
    case Checker = "Checker"
}

protocol HolidayPreferences {
    func setObject(value: AnyObject?,
        forKey defaultName: String)
    func objectForKey(defaultName: String) -> AnyObject?
    func synchronize() -> Bool
}

extension NSUserDefaults:HolidayPreferences {}

extension HolidayPreferences {
    var currentChecker:HolidayChecker {
        get {
            return (self.objectForKey(HolidayPreferencesKeys.Checker.rawValue) as? HolidayChecker)  ?? .Christmas
        }
        set (value){
            self.setObject(value.rawValue, forKey: HolidayPreferencesKeys.Checker.rawValue)
        }
    }
}
