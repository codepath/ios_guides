//
//  DetailViewController.swift
//  FontBrowserDemo
//
//  Created by Benjamin Sandofsky on 10/24/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

private let CELL_IDENTIFIER = "com.codepath.fontsdemocell"
private let PLACEHOLDER_TEXT = "The quick brown fox jumps over the lazy dog"

class DetailViewController: UIViewController {

    @IBOutlet weak var fontsTableView: UITableView!
    var fonts = [UIFont]()
    var fontSize:CGFloat = 13.0
    var fontFamilyName: FontFamilyName? {
        didSet {
            self.reloadFonts()
            self.navigationItem.title = fontFamilyName
            if self.isViewLoaded() {
                self.configureView()
            }
        }
    }

    private func reloadFonts() {
        if let familyName = fontFamilyName {
            self.fonts = UIFont.fontNamesForFamilyName(familyName).map {
                UIFont(name: $0, size: fontSize)
            }.filter { $0 != nil }.map { $0! }
        }
    }

    private func configureView() {
        fontsTableView.reloadData()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER)!
        cell.textLabel?.text = PLACEHOLDER_TEXT
        cell.textLabel?.font = fonts[indexPath.row]
        return cell
    }
}