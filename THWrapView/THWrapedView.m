//
//  THWrapedView.m
//  THWrapedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 lazy-thuai. All rights reserved.
//

#import "THWrapedView.h"
#import "THWrapCell.h"

#define DEFAULT_CELL_HEIGHT     50
#define DEFAULT_CELL_WIDTH      50


@interface THWrapedView ()

@property (nonatomic        ) NSInteger      cellAllocCount;    // the count of cells that alloced to be reuseable
@property (nonatomic, strong) NSMutableArray *visibleCells;     // the array of cells that display on the screen
@property (nonatomic        ) CGFloat        upRowMaxHeight;    // the max height of upper row
@property (nonatomic        ) BOOL           leftCell;

@end

@implementation THWrapedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray *)visibleCells
{
    if (!_visibleCells) {
        _visibleCells = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _visibleCells;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsForWrapView:)]) {
        edgeInsets = [self.delegate edgeInsetsForWrapView:self];
    }
    
    // valid area size to layout subviews
    CGFloat validWidth = CGRectGetWidth(self.frame) - edgeInsets.left;

    // the total width of layout subview
    __block CGFloat layoutedWidth = edgeInsets.left;
    __block CGFloat layoutedHeight = edgeInsets.top;
    __block CGFloat rowMaxHeight = 0.0;
    
    CGFloat lineSpacing = 0.0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(minimumLineSpacingOfWrapView:)]) {
        lineSpacing = [self.delegate minimumLineSpacingOfWrapView:self];
    }
    
    CGFloat interitemSpacing = 0.0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(minimumInteritemSpacingOfWrapView:)]) {
        interitemSpacing = [self.delegate minimumInteritemSpacingOfWrapView:self];
    }
    
    __block BOOL nextRow = NO;
    
    [self.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView *)obj;
        CGRect newFrame = view.frame;
        if (self.delegate && [self.delegate respondsToSelector:@selector(sizeOfCellAtIndexPath:)]) {
            CGSize size = [self.delegate sizeOfCellAtIndexPath:[NSIndexPath indexPathWithIndex:idx]];
            newFrame.size = size;
        }
        
        if (layoutedWidth + newFrame.size.width > validWidth) {
            nextRow = YES;
            layoutedWidth = edgeInsets.left;
            layoutedHeight += rowMaxHeight;
            rowMaxHeight = newFrame.size.height;
        }
        
        newFrame.origin.x = layoutedWidth + interitemSpacing;
        newFrame.origin.y = layoutedHeight + lineSpacing;

        CGFloat tmpHeight = newFrame.size.height + lineSpacing;
        rowMaxHeight = rowMaxHeight > tmpHeight ? rowMaxHeight : tmpHeight;
        
        layoutedWidth += newFrame.size.width + interitemSpacing;

        view.frame = newFrame;
    }];
}

- (void)reloadData
{
    _cellAllocCount = [self calculateCellAllocCount];

    NSInteger allocedCount = [self.visibleCells count];
    if (allocedCount > _cellAllocCount) {
        // remove the cell because there are too many alloced cells
        for (NSInteger i=allocedCount - 1; i>_cellAllocCount-1; i--) {
            UIView *view = [self.visibleCells objectAtIndex:i];
            if ([view superview]) {
                [view removeFromSuperview];
            }
            [self.visibleCells removeObject:view];
        }
    } else if (allocedCount < _cellAllocCount) {
        // new more cell because there is not enough cell to be displayed
        NSInteger newCount = _cellAllocCount - allocedCount;
        for (int i=0; i<newCount; i++) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(wrapView:cellForIndex:)]) {
                THWrapCell *cell = [self.dataSource wrapView:self cellForIndex:i];
                [self.visibleCells addObject:cell];
                [self addSubview:cell];
            }
        }
    }
    
    [self setNeedsLayout];
}

- (NSInteger)calculateCellAllocCount
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfCell)]) {
        return [self.dataSource numberOfCell];
    }
    return 0;
}

- (THWrapCell *)dequeueReusableCellWithIndex:(NSUInteger)index
{
    NSUInteger cellCount = [self.visibleCells count];
    if (index > 0 && index < cellCount) {
        return [self.visibleCells objectAtIndex:index];
    }
    return nil;
} 

@end
