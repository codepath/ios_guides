//
//  DetailViewController.swift
//  ViewControllerTransitionDemo
//
//  Created by Ben Sandofsky on 3/1/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    override func loadView(){
        let v = UIView(frame:CGRectZero)
        v.backgroundColor = UIColor.greenColor()
        self.view = v
    }
    
}
