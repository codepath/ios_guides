//
//  TodoItemTableViewCell.swift
//  PeristenceDemo
//
//  Created by Ben Sandofsky on 3/15/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

protocol TodoItemTableViewCellDelegate: class {
    func todoItemCell(cell:TodoItemTableViewCell, didFinishEditingItem item:TodoItem)
}

class TodoItemTableViewCell: UITableViewCell {
    weak var delegate:TodoItemTableViewCellDelegate?

    var todoItem:TodoItem! {
        didSet(oldItem){
            self.updateTextField()
        }
    }

    @IBOutlet weak var itemTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        itemTextField.delegate = self
        itemTextField.addTarget(self, action: "textChanged:", forControlEvents: .EditingChanged)
    }

    func textChanged(sender:UITextField){
        todoItem.text = itemTextField.text!
    }

    private func updateTextField(){
        itemTextField.text = self.todoItem.text
    }
}

extension TodoItemTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.todoItemCell(self, didFinishEditingItem: todoItem)
    }
}
