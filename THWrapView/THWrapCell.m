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
    }
    return self;
}

- (instancetype)initWithCellStyle:(THWrapCellStyle)style
{
    return [self initWithFrame:CGRectZero];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.wrapView && self.wrapView.selectedCellBlock) {
        if (self.wrapView.selectedCellBlock) {
            self.wrapView.selectedCellBlock(self.indexPath);
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}

@end
