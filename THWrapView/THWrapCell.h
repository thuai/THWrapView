//
//  THWrapCell.h
//  THWrapedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 lazy-thuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, THWrapCellStyle) {
    THWrapCellStyleDefault,
};

@class THWrapedView;

@interface THWrapCell : UIView

@property (nonatomic) THWrapedView *wrapView;
@property (nonatomic) NSIndexPath *indexPath;

- (instancetype)initWithCellStyle:(THWrapCellStyle)style;
@end
