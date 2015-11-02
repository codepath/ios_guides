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
enum HolidayCheckerPreferenceValue:String {
    case Christmas = "Christmas"
    var checker:HolidayChecker.Type {
        switch self {
        case Christmas:
            return ChristmasChecker.self
        }
    }
    var localizedTitle:String {
        switch self {
        case .Christmas:
            return "Christmas"
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
    var currentChecker:HolidayCheckerPreferenceValue {
        get {
            return (self.objectForKey(HolidayPreferencesKeys.Checker.rawValue) as? HolidayCheckerPreferenceValue)  ?? .Christmas
        }
        set (value){
            self.setObject(value.rawValue, forKey: HolidayPreferencesKeys.Checker.rawValue)
        }
    }
}
