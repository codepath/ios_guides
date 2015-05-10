//
//  ViewController.swift
//  WatchHelloWorld
//
//  Created by Ben Sandofsky on 5/10/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let message = HelloWorldMessage()
        helloLabel.text = message.generateText()
    }
}

