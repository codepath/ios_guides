//
//  DealWithItGenerator.swift
//  DealWithIt
//
//  Created by Ben Sandofsky on 6/22/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit
import CoreImage
import ImageIO

class DealWithItGenerator: NSObject {
    var sourceImage:UIImage
    init(sourceImage:UIImage) {
        self.sourceImage = sourceImage
        super.init()
    }

    func detectFaces() -> [CIFaceFeature] {
        let image = CIImage(CGImage: sourceImage.CGImage!)

        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        var detectionOptions:[String : AnyObject] = Dictionary()
        if let orientation = image.properties[kCGImagePropertyOrientation as String] as? String {
            detectionOptions[CIDetectorImageOrientation] = orientation
        }
        return detector.featuresInImage(image, options: detectionOptions) as! [CIFaceFeature]
    }

    func generateDealWithItImage() -> UIImage {
        let faces = self.detectFaces()
        NSLog("Faces: \(faces)")
        UIGraphicsBeginImageContextWithOptions(sourceImage.size, true, sourceImage.scale)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        CGContextTranslateCTM(ctx, 0.0, sourceImage.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        CGContextDrawImage(ctx, CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height), sourceImage.CGImage!)
        let glassesImage = UIImage(named: "sunglasses")!
        for faceFeature in faces {
            let faceRect = faceFeature.bounds
            let glassesWidth = faceRect.size.width
            let glassesHeight = (glassesWidth / glassesImage.size.width) * glassesImage.size.height
            let glassesY:CGFloat
            let glassesX:CGFloat
            let leftNudge = glassesWidth / 2.8
            if faceFeature.hasLeftEyePosition {
                glassesX = faceFeature.leftEyePosition.x - leftNudge
                glassesY = faceFeature.leftEyePosition.y - glassesHeight / 3.0
            } else {
                glassesX = faceRect.origin.x - leftNudge
                glassesY = faceRect.origin.y + (faceRect.size.height / 3.0)
            }
            CGContextDrawImage(ctx, CGRectMake(glassesX, glassesY, glassesWidth, glassesHeight), glassesImage.CGImage!)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        CGContextRestoreGState(ctx)
        UIGraphicsEndImageContext()
        return image
    }
    
}
