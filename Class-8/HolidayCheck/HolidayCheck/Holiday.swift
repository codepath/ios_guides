//
//  Holiday.swift
//  HolidayCheck
//
//  Created by Benjamin Sandofsky on 11/1/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import Foundation

protocol Holiday {
    var localizedTitle:String { get }
    var localizedDescription:String { get }
}