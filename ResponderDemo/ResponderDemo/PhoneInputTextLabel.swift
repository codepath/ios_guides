//
//  PhoneInputTextLabel.swift
//  ResponderDemo
//
//  Created by Benjamin Sandofsky on 5/31/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

protocol PhoneInputTextLabelDelegate: class {
    func didUpdatePhoneInputLabel(label: PhoneInputTextLabel)
}

private let PRIMARY_FONT = UIFont.systemFontOfSize(17.0)
private let PRIMARY_COLOR = UIColor.blackColor()
private let PLACEHOLDER_COLOR = UIColor.grayColor()

@IBDesignable
class PhoneInputTextLabel: UILabel, UIKeyInput, UITextInputTraits {
    weak var delegate:PhoneInputTextLabelDelegate?
    var inputNumber:String = "" {
        didSet(oldValue){
            self._updateLabel()
        }
    }

    private func finishInitialization(){
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.textAlignment = .Center
        _updateLabel()
        var tapGesture = UITapGestureRecognizer(target: self, action: "didTap:")
        self.addGestureRecognizer(tapGesture)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInitialization()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        finishInitialization()
    }

    func didTap(sender:UITapGestureRecognizer){
        self.becomeFirstResponder()
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        finishInitialization()
    }
    
    private func _updateLabel(){
        if count(inputNumber.utf16) > 0 {
            self.attributedText = NSAttributedString(string: _formattedNumber(), attributes: [NSFontAttributeName: PRIMARY_FONT,
                NSForegroundColorAttributeName: PRIMARY_COLOR])
        } else {
            self.attributedText = NSAttributedString(string: "Add a Phone Number", attributes: [NSFontAttributeName: PRIMARY_FONT,
                NSForegroundColorAttributeName: PLACEHOLDER_COLOR])
        }
    }
    
    private func _formattedNumber() -> String {
        var fullLength = NSMakeRange(0, count(inputNumber.utf16))
        var phoneRanges:[NSRange] = [
            NSMakeRange(0, 1),
            NSMakeRange(1, 3),
            NSMakeRange(4, 3),
            NSMakeRange(7, 4)]
        let rangesStrings:[String] = phoneRanges.map { range in
            let subRange = NSIntersectionRange(fullLength, range)
            return (self.inputNumber as NSString).substringWithRange(subRange)
        }
        let finalStrings = rangesStrings.filter({ count($0.utf16) > 0 })
        let s = (finalStrings as NSArray).componentsJoinedByString("–")
        switch fullLength.length {
        case 1, 4, 7:
            return "\(s)–"
        default:
            return s
        }
    }
    
    func insertText(text: String) {
        if count(inputNumber.utf16) == MAX_PHONE_LENGTH {
            return
        }
        var textToInsert = text
        if inputNumber == "" {
            if text != "1" {
                textToInsert = "1\(text)"
            }
        }
        inputNumber = inputNumber.stringByAppendingString(textToInsert)
        delegate?.didUpdatePhoneInputLabel(self)
    }
    
    func deleteBackward() {
        let newEnd = max(count(inputNumber.utf16) - 1, 0)
        inputNumber = (inputNumber as NSString).substringToIndex(newEnd)
        delegate?.didUpdatePhoneInputLabel(self)
    }
    
    func hasText() -> Bool {
        return count(inputNumber.utf16) > 0
    }

    var keyboardType:UIKeyboardType {
        get {
            return UIKeyboardType.NumberPad
        }
        set(value) {
            
        }
    }

    var keyboardAppearance: UIKeyboardAppearance {
        get {
            return UIKeyboardAppearance.Dark
        }
        set(value){
            
        }
    }
}
private let MAX_PHONE_LENGTH = 11