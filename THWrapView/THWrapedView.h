//
//  THWrapedView.h
//  THWrapedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 lazy-thuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THWrapedView;
@class THWrapCell;

@protocol THWrapedViewDataSource <NSObject>

- (NSInteger)numberOfCell;
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