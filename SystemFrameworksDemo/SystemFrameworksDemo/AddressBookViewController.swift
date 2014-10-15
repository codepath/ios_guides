//
//  AddressBookViewController.swift
//  SystemFrameworksDemo
//
//  Created by Ben Sandofsky on 10/15/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit
import AddressBook

private let NAME_CELL_IDENTIFER = "com.codepath.addressbook.namecell"

class AddressBookViewController: UIViewController, UITableViewDataSource {

    var addressBook: ABAddressBook!
    var names:[String]?

    @IBOutlet weak var namesTableView: UITableView!

    private func _initalizeAddressBook() {
        var err : Unmanaged<CFError>? = nil
        var addressBookPointer: Unmanaged<ABAddressBook>? = ABAddressBookCreateWithOptions(nil, &err)
        assert(err != nil, "Error initializing Address book:\(err)")
        addressBook = addressBookPointer?.takeRetainedValue()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _initalizeAddressBook()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _initalizeAddressBook()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.namesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NAME_CELL_IDENTIFER)
    }

    @IBAction func didTapFetch(sender: AnyObject) {
        switch (ABAddressBookGetAuthorizationStatus()){
        case .NotDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook) {
                success, error in
                if success {
                    self.beginContactSearch()
                } else {
                    NSLog("Restricted")
                }
            }
        case .Denied, .Restricted:
            NSLog("Restricted")
        case .Authorized:
            self.beginContactSearch()
        }
    }

    func beginContactSearch(){
        let records = ABAddressBookCopyArrayOfAllPeople(self.addressBook).takeRetainedValue() as NSArray as [ABRecord]
        names = Array()
        for record in records {
            let object = ABRecordCopyCompositeName(record)
            if object.toOpaque() == COpaquePointer.null() {

            } else {
                var name = object.takeRetainedValue() as NSString
                names!.append(name)
            }
        }
        namesTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = namesTableView.dequeueReusableCellWithIdentifier(NAME_CELL_IDENTIFER) as UITableViewCell
        cell.textLabel!.text = names![indexPath.row]
        return cell
    }
}
