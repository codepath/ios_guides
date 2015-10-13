//
//  PhotosViewController.swift
//  SystemFrameworksDemo
//
//  Created by Ben Sandofsky on 10/14/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func didTapLoadFromLibrary(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .PhotoLibrary
            picker.delegate = self
            self.presentViewController(picker, animated: true) { }
        } else {
            NSLog("Photo Library unavailable.")
        }
    }

    @IBAction func didTapLoadFromCamera(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            let picker = UIImagePickerController()
            picker.sourceType = .Camera
            picker.delegate = self
            self.presentViewController(picker, animated: true) { }
        } else {
            NSLog("Camera unavailable.")
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true) {}
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        NSLog("Canceled picker")
        self.dismissViewControllerAnimated(true) {}
    }
}
