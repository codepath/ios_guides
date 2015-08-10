//
//  SnowViewController.m
//  AdvancedGraphics
//
//  Created by Benjamin Sandofsky on 8/7/15.
//  Copyright © 2015 Chroma Noir LLC. All rights reserved.
//

#import "SnowViewController.h"

#define SNOW_COUNT 20

@interface SnowViewController ()
@property (nonatomic, strong) NSMutableArray<SnowLayer *> *snowQueue;
@end

@implementation SnowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray<SnowLayer *> *array = [NSMutableArray array];
    UIImage *snowFlakeImage = [UIImage imageNamed:@"snowflake"];
    for (int i = 0; i < SNOW_COUNT; i++){
        SnowLayer *snow = [[SnowLayer alloc] init];
        snow.contents = (id)snowFlakeImage.CGImage;
        snow.frame = CGRectMake(0, -40, 40, 40);
        [self.view.layer addSublayer:snow];
        [array addObject:snow];
    }
    self.snowQueue = array;
}

- (IBAction)didTapStart:(UIBarButtonItem *)sender {
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    CGFloat offset = 0.0;
    for (SnowLayer *snow in self.snowQueue) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        CGFloat x = (CGFloat)arc4random() / (CGFloat)UINT32_MAX * self.view.layer.bounds.size.width;
        CGPoint p = CGPointMake(x, -20.0);
        animation.fromValue = [NSValue valueWithCGPoint:p];
        animation.keyPath = @"position";
        p.y = self.view.frame.size.height + 20.0;
        animation.toValue = [NSValue valueWithCGPoint:p];
        CGFloat randomOffset = (CGFloat)arc4random() / (CGFloat)UINT32_MAX;
        offset += 0.5 + randomOffset / 2.0;
        animation.beginTime = CACurrentMediaTime() + offset;
        animation.repeatCount = 1000;
        [snow addAnimation:animation forKey:@"snowFall"];
        NSLog(@"Snowed: %f", x);
    }
    
    [CATransaction commit];
}

@end

@implementation SnowLayer

@end