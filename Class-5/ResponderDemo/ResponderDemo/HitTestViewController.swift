//
//  HitTestViewController.swift
//  ResponderDemo
//
//  Created by Benjamin Sandofsky on 5/31/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class HitTestViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var myCustomRootView: MyRootView!

    @IBOutlet weak var myTableView: UITableView!

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myCustomRootView.realTarget = myTableView
    }
}

class MyRootView:UIView {
    weak var realTarget:UIView?
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if let target = realTarget {
            return target
        } else {
            return super.hitTest(point, withEvent: event)
        }
    }
}