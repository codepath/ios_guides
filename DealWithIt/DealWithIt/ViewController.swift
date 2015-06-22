//
//  ViewController.swift
//  DealWithIt
//
//  Created by Ben Sandofsky on 6/22/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func didTapPhotoButton(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.navigationController?.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBOutlet weak var finalImageView: UIImageView!
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let generator = DealWithItGenerator(sourceImage: image)
        self.finalImageView.image = generator.generateDealWithItImage()
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

