//
//  FibonacciEntry.swift
//  PerformanceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class FibonacciEntry {
    var number:Int
    var result:Int?
    init(number:Int){
        self.number = number
    }
    func calculate() -> Int {
        var a = 0
        var b = 1
        var c = 1
        for var i = 0; i < number; i++ {
            c = a + b
            a = b
            b = c
        }
        return c
    }
}
