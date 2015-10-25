//
//  QuestionViewController.swift
//  FlashCard
//
//  Created by Benjamin Sandofsky on 10/25/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    class func questionViewController() -> QuestionViewController {
        let storyboard = UIStoryboard(name: "QuestionViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! QuestionViewController
    }

    var question = QuestionViewController.loadExampleQuestion() {
        didSet {
            if self.isViewLoaded() {
                updateLabel()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    private static func loadExampleQuestion() -> Question {
        let text = "Beans are ground or pounded to the finest possible powder, finer than for any other way of preparation."
        let summary = "Turkish coffee"
        let longAnswer = "Turkish coffee is a method of preparation, not a kind of coffee. Therefore, there is no special type of bean. Beans for Turkish coffee are ground or pounded to the finest possible powder; finer than for any other way of preparation. The grinding is done either by pounding in a mortar (the original method) or using a burr mill. Most domestic coffee mills are unable to grind finely enough; traditional Turkish hand grinders are an exception."
        let answer = Answer(summary:summary, longAnswer:longAnswer)
        return Question(text:text, answer:answer)
    }

    
    @IBAction func didTapShowAnswer(sender: AnyObject) {
        let answerController = AnswerViewController.answerViewController()
        answerController.answer = question.answer
        self.showDetailViewController(answerController, sender: self)
    }

    private func updateLabel(){
        questionLabel.text = question.text
    }
}
