//
//  ImplicitAnimationViewController.m
//  AdvancedGraphics
//
//  Created by Ben Sandofsky on 8/7/15.
//  Copyright © 2015 Chroma Noir LLC. All rights reserved.
//

#import "ImplicitAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ImplicitAnimationViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerConstraint;
@property (weak, nonatomic) IBOutlet MyCustomView *animatedView;

@end

@implementation ImplicitAnimationViewController
- (IBAction)didTapGo:(UIBarButtonItem *)sender {
    self.centerConstraint.constant = 100;
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
        self.animatedView.isGoing = true;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.centerConstraint.constant = -100;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    return nil;
}

@end

@implementation MyCustomView

+ (Class)layerClass {
    return [MyCustomLayer class];
}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id action = [super actionForLayer:layer forKey:event];
    NSLog(@"key: %@, Action: %@", event, action);
    return action;
}

- (void)setIsGoing:(BOOL)isGoing
{
    MyCustomLayer *l = (MyCustomLayer *)self.layer;
    l.isGoing = isGoing;
}

- (BOOL)isGoing
{
    return [(MyCustomLayer *)self.layer isGoing];
}

@end

@implementation MyCustomLayer
- (id)init
{
    self = [super init];
    if (self){
        [self _updateColor];
    }
    return self;
}
- (void)setIsGoing:(BOOL)isGoing
{
    _isGoing = isGoing;
    [self _updateColor];
}

- (void)_updateColor
{
    self.backgroundColor = _isGoing ? [UIColor greenColor].CGColor : [UIColor redColor].CGColor;
}

@end