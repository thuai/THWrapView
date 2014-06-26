//
//  THWrapedView.h
//  THWrapedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 lazy-thuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THWrapedView;
@class THWrapCell;

@protocol THWrapedViewDataSource <NSObject>

- (NSInteger)numberOfCell; // 总的cell数
- (THWrapCell *)wrapView:(THWrapedView *)wrapView cellForIndex:(NSUInteger)index;

@end

@protocol THWrapedViewDelegate <NSObject>

- (CGSize)sizeOfCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)edgeInsetsForWrapView:(THWrapedView *)wrapView;
- (CGFloat)minimumLineSpacingOfWrapView:(THWrapedView *)wrapView;
- (CGFloat)minimumInteritemSpacingOfWrapView:(THWrapedView *)wrapView;
@end

typedef void (^THWrapDidSelectedCellBlock)(NSIndexPath *indexPath);
typedef void (^THWrapDidDeselectedCellBlock)(NSIndexPath *indexPath);

@interface THWrapedView : UIView

@property (nonatomic, copy  ) THWrapDidSelectedCellBlock   selectedCellBlock;
@property (nonatomic, copy  ) THWrapDidDeselectedCellBlock deselectedCellBlock;
@property (nonatomic, assign) id<THWrapedViewDataSource> dataSource;
@property (nonatomic, assign) id<THWrapedViewDelegate  > delegate;

- (void)reloadData;
- (THWrapCell *)dequeueReusableCellWithIndex:(NSUInteger)index;
@end