//
//  TodoListTableViewController.swift
//  PeristenceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController, TodoItemTableViewCellDelegate {

    var items:[TodoItem] = Array() {
        didSet(oldItems){
            self.tableView.reloadData()
        }
    }

    var managedObjectContext:NSManagedObjectContext!

    @IBOutlet weak var itemTextField: UITextField!

    @IBAction func didTapAdd(sender: UIButton) {
        let newItem = TodoItem(text: itemTextField.text!)
        itemTextField.text = ""
        self.tableView.beginUpdates()
        items.insert(newItem, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        self.tableView.endUpdates()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ITEM_CELL_IDENTIFIER) as! TodoItemTableViewCell
        cell.todoItem = items[indexPath.row]
        cell.delegate = self
        return cell
    }

    func todoItemCell(cell:TodoItemTableViewCell, didFinishEditingItem item:TodoItem) {
        NSLog("Would save item")
    }

}

private let ITEM_CELL_IDENTIFIER = "com.codepath.peristence.todolistitem"