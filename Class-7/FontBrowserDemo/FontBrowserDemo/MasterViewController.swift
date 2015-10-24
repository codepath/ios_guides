//
//  MasterViewController.swift
//  FontBrowserDemo
//
//  Created by Benjamin Sandofsky on 10/24/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

typealias FontFamilyName = String

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var fontFamilies = [FontFamilyName]()


    override func viewDidLoad() {
        super.viewDidLoad()
        fontFamilies = UIFont.familyNames().sort()
        self.tableView.reloadData()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let fontFamily = fontFamilies[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.fontFamilyName = fontFamily
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontFamilies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let name = fontFamilies[indexPath.row]
        cell.textLabel!.text = name
        return cell
    }

}

