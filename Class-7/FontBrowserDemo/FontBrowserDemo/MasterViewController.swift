//
//  MasterViewController.swift
//  FontBrowserDemo
//
//  Created by Benjamin Sandofsky on 10/24/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

typealias FontFamilyName = String
let SETTINGS_SEGUE = "com.codepath.settingsSegue"
let DETAIL_IDENTIFIER = "com.codepath.fontDetailNavigation"
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
        if segue.identifier == SETTINGS_SEGUE {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! GlobalSettingsViewController
            controller.delegate = self
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let fontFamily = fontFamilies[indexPath.row]
        let detailNav = self.storyboard!.instantiateViewControllerWithIdentifier(DETAIL_IDENTIFIER) as! UINavigationController
        let detailVC = detailNav.viewControllers[0] as! DetailViewController
        detailVC.fontFamilyName = fontFamily
        self.showDetailViewController(detailNav, sender: self)
    }
}

extension MasterViewController:GlobalSettingsViewControllerDelegate {
    func didCompleteGlobalSettingsController(controller: GlobalSettingsViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}