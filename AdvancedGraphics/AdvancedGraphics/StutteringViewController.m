//
//  StutteringViewController.m
//  AdvancedGraphics
//
//  Created by Ben Sandofsky on 8/4/15.
//  Copyright © 2015 Chroma Noir LLC. All rights reserved.
//

#import "StutteringViewController.h"

@interface StutteringViewController ()

@end


@interface SlowView:UIView
@end

@interface SlowCell:UITableViewCell
@property (weak, nonatomic) IBOutlet SlowView *slowView;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@end


@implementation StutteringViewController

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SlowCell *cell = (SlowCell *)[tableView dequeueReusableCellWithIdentifier:@"com.codepath.slowcell"];
    cell.centerLabel.text = [NSString stringWithFormat:@"Row: %li", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

@end

@implementation SlowCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.slowView.opaque = false;
    self.slowView.backgroundColor = [UIColor clearColor];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.slowView setNeedsDisplay];
}
@end

@implementation SlowView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    CGContextDrawImage(ctx, rect, [UIImage imageNamed:@"yosemite.jpg"].CGImage);
    for (int i = 0; i < 10; i++){
        CGContextSetRGBFillColor(ctx, 1.0 - (i / 10.0), 0, 0, 0.5);
        CGContextFillRect(ctx, CGRectInset(rect, i * 10, i * 10));
    }
}

@end