//
//  TodoItem.swift
//  PeristenceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class TodoItem: NSObject {
    var text:String
    init(text initialText:String){
        self.text = initialText
    }
}
