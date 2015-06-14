//
//  SlowScrollingTableViewController.swift
//  PerformanceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

let FIBONACCI_CELL_IDENTIFIER = "com.codepath.fibonacci"

class SlowScrollingTableViewController: UITableViewController {

    var entries:[FibonacciEntry] = Array()

    override func awakeFromNib() {
        super.awakeFromNib()
        for var i = 0; i < 75; i++ {
            entries.append(FibonacciEntry(number:i))
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FIBONACCI_CELL_IDENTIFIER) as! FibonacciCell
        cell.fibonacciEntry = entries[indexPath.row]
        return cell
    }
}

class FibonacciCell:UITableViewCell {
    var fibonacciEntry:FibonacciEntry? {
        didSet(oldEntry){
            _updateLabel()
            if fibonacciEntry == nil {
                return
            }
            let entry = fibonacciEntry!
            if entry.result == nil {
                for var i = 0; i < 100000; i++ {
                    entry.calculate()
                }
                self.fibonacciEntry?.result = entry.calculate()
                self._updateLabel()
            }
        }
    }

    private func _updateLabel(){
        if let result = fibonacciEntry?.result {
            self.textLabel?.text = "\(result)"
        } else {
            self.textLabel?.text = ""
        }
    }
}