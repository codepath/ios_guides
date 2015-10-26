//
//  AnswerViewController.swift
//  FlashCard
//
//  Created by Benjamin Sandofsky on 10/25/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var longAnswerLabel: UILabel!

    class func answerViewController() -> AnswerViewController {
        let storyboard = UIStoryboard(name: "AnswerViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! AnswerViewController
    }

    var answer:Answer? {
        didSet {
            updateLabels()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }

    private func updateLabels(){
        guard isViewLoaded() else {
            return
        }
        if let availableAnswer = answer {
            summaryLabel.text = availableAnswer.summary
            longAnswerLabel.text = availableAnswer.longAnswer
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
}
