import UIKit

let image = UIImage(named: "avatar")!
UIGraphicsBeginImageContext(image.size)
let s = image.size
let f = CGRectMake(0, 0, s.width, s.height)
let ctx = UIGraphicsGetCurrentContext()
CGContextBeginPath(ctx)
CGContextAddArc(ctx, CGFloat(320.0), CGFloat(320.0), CGFloat(320), CGFloat(0), CGFloat(2 * M_PI), 1)
CGContextClosePath(ctx)
CGContextClip(ctx)
CGContextSaveGState(ctx)
CGContextTranslateCTM(ctx, 0.0, s.height)
CGContextScaleCTM(ctx, 1.0, -1.0)
CGContextDrawImage(ctx, f, image.CGImage)
CGContextRestoreGState(ctx)
let circularAvatar = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
