//
//  ExpandingImageViewController.m
//  AdvancedGraphics
//
//  Created by Ben Sandofsky on 8/7/15.
//  Copyright © 2015 Chroma Noir LLC. All rights reserved.
//

#import "ExpandingImageViewController.h"

@interface FakeImageView:UIView
@end

@interface ExpandingImageViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet FakeImageView *imageView;
@property (assign, nonatomic) BOOL isToggled;
@end

@implementation ExpandingImageViewController

- (IBAction)didTapToggle:(UIBarButtonItem *)sender {
    _isToggled = !_isToggled;
    if (_isToggled){
        self.widthConstraint.constant = 100.0;
        self.heightConstraint.constant = 100.0;
    } else {
        self.widthConstraint.constant = 44.0;
        self.heightConstraint.constant = 44.0;
    }

    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        
    }];
}

@end

@implementation FakeImageView

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"lombard"];
    [image drawInRect:rect];
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

@end