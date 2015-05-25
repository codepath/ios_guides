//
//  MyCustomView.swift
//  AppearanceDemo
//
//  Created by Benjamin Sandofsky on 5/25/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class MyCustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaults()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaults()
    }

    private func setDefaults(){
        self.topColor = UIColor(white: 0.8, alpha: 1.0)
        self.bottomColor = UIColor(white: 0.5, alpha: 1.0)
    }

    var topColor:UIColor? {
        didSet {
            updateGradient()
        }
    }

    var bottomColor:UIColor? {
        didSet {
            updateGradient()
        }
    }

    private func updateGradient() {
        let topCGColor = (self.topColor ?? UIColor.whiteColor()).CGColor
        let bottomCGColor = (self.bottomColor ?? UIColor.whiteColor()).CGColor
        self.gradientLayer.colors = [topCGColor, bottomCGColor]
    }

    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }

    var gradientLayer:CAGradientLayer {
        get {
            return self.layer as! CAGradientLayer
        }
    }
}
