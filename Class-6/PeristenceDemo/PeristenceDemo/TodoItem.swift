//
//  TodoItem.swift
//  PeristenceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit
import CoreData

class TodoItem: NSObject {
    var text:String
    init(text initialText:String){
        self.text = initialText
    }

}

/*
let TODO_ITEM_ENTITY_NAME = "Item"

@objc(TodoItem)

class TodoItem:NSManagedObject {
    @NSManaged var text:String?
}
*/
