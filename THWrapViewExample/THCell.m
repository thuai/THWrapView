//
//  THCell.m
//  THWrappedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 lazy-thuai. All rights reserved.
//

#import "THCell.h"

@implementation THCell

- (instancetype)initWithCellStyle:(THWrapCellStyle)style
{
    self = [super initWithCellStyle:style];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
