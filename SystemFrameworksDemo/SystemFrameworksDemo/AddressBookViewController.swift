//
//  AddressBookViewController.swift
//  SystemFrameworksDemo
//
//  Created by Ben Sandofsky on 10/15/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit
import Contacts

private let NAME_CELL_IDENTIFER = "com.codepath.addressbook.namecell"
class AddressBookViewController: UIViewController, UITableViewDataSource {

    var names:[String]?

    @IBOutlet weak var namesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.namesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NAME_CELL_IDENTIFER)
    }

    @IBAction func didTapFetch(sender: AnyObject) {
        CNContactStore().requestAccessForEntityType(CNEntityType.Contacts) { (success, errorOrNil) -> Void in
            guard success else {
                NSLog("Error: \(errorOrNil)")
                return
            }
            self.beginContactSearch()
        }
    }

    func beginContactSearch(){
        names = Array()
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactEmailAddressesKey])
        try! CNContactStore().enumerateContactsWithFetchRequest(fetchRequest) { contact, stopPointer in
            for value in contact.emailAddresses {
                if let string = value.value as? String {
                    self.names?.append(string)
                }
            }
        }
        dispatch_async(dispatch_get_main_queue()){
            self.namesTableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = namesTableView.dequeueReusableCellWithIdentifier(NAME_CELL_IDENTIFER)!
        cell.textLabel!.text = names![indexPath.row]
        return cell
    }
}
