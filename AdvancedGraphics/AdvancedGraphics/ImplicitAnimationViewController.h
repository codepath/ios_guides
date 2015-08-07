//
//  ImplicitAnimationViewController.h
//  AdvancedGraphics
//
//  Created by Ben Sandofsky on 8/7/15.
//  Copyright © 2015 Chroma Noir LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImplicitAnimationViewController : UIViewController
@end

@interface MyCustomView : UIView
@property (nonatomic, assign) BOOL isGoing;
@end

@interface MyCustomLayer:CALayer
@property (nonatomic, assign) BOOL isGoing;
@end