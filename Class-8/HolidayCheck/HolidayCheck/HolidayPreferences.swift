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

enum HolidayChecker:String {
    case Christmas = "Christmas"
    case NewYears = "NewYears"

    var localizedTitle:String {
        switch self {
        case .Christmas:
            return "Christmas"
        case .NewYears:
            return "New Year's"
        }
    }
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
