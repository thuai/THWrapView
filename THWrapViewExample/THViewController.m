//
//  THViewController.m
//  THWrapedViewExample
//
//  Created by lazy-thuai on 14-6-13.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "THViewController.h"
#import "THCell.h"

@interface THViewController ()

@property (nonatomic, strong) THWrapedView *wrapView;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.wrapView = [[THWrapedView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    self.wrapView.dataSource = self;
    self.wrapView.delegate = self;
    [self.view addSubview:self.wrapView];
    
    [self.wrapView reloadData];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(60, 400, 200, 40)];
    slider.tag = 1;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(60, 440, 200, 40)];
    slider2.tag = 2;
    slider2.value = 1.0;
    [slider2 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider2];
    self.slider = slider2;
}

#pragma mark - THWrapedViewDataSource

- (NSInteger)numberOfCell
{
    return 20;
}

- (THWrapCell *)wrapView:(THWrapedView *)wrapView cellForIndex:(NSUInteger)index
{
    THWrapCell *cell = [wrapView dequeueReusableCellWithIndex:index];
    if (!cell) {
        cell = [[THCell alloc] initWithCellStyle:THWrapCellStyleDefault];
    }
    return cell;
}

#pragma mark - THWrapedViewDelegate

- (CGSize)sizeOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat value = (CGFloat)(arc4random() % 100) / 100;
    return CGSizeMake(50 * value, 50 * value);
}

- (UIEdgeInsets)edgeInsetsForWrapView:(THWrapedView *)wrapView
{
    return UIEdgeInsetsZero;
}

- (CGFloat)minimumInteritemSpacingOfWrapView:(THWrapedView *)wrapView
{
    return 4;
}

- (CGFloat)minimumLineSpacingOfWrapView:(THWrapedView *)wrapView
{
    return 2;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    if (slider.tag == 2) {
        [self.wrapView reloadData];
    } else {
        CGRect newFrame = self.wrapView.frame;
        newFrame.size.width = 320 * slider.value;
        self.wrapView.frame = newFrame;
    }
}
@end
