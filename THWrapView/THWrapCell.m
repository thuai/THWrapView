//
//  THWrapCell.m
//  THWrapedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 lazy-thuai. All rights reserved.
//

#import "THWrapCell.h"
#import "THWrapedView.h"

@implementation THWrapCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.normalColor = [UIColor whiteColor];
        self.highlightColor = [UIColor colorWithRed:0xee/255.0 green:0xee/255.0 blue:0xee/255.0 alpha:1];
    }
    return self;
}

- (instancetype)initWithCellStyle:(THWrapCellStyle)style
{
    return [self initWithFrame:CGRectZero];
}

#pragma mark -
#pragma mark Setters & Getters

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    self.backgroundColor = normalColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = self.highlightColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.04 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = self.normalColor;
    });
    
    if (self.wrapView && self.wrapView.selectedCellBlock) {
        if (self.wrapView.selectedCellBlock) {
            self.wrapView.selectedCellBlock(self.index);
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.04 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = self.normalColor;
    });
}

@end
