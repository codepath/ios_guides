//
//  HelloWorldMessage.swift
//  WatchHelloWorld
//
//  Created by Ben Sandofsky on 5/10/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class HelloWorldMessage: NSObject {
    func generateText() -> String {
        return "Hello World.\nThe time is now \(_dateFormatter.stringFromDate(NSDate()))"
    }
}

let _dateFormatter:NSDateFormatter = {
    var formatter = NSDateFormatter()
    formatter.dateStyle = .NoStyle
    formatter.timeStyle = .LongStyle
    return formatter
}()