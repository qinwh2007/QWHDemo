//
//  SegmentsController.m
//  testNav
//
//  Created by qinwh2008 on 17/2/7.
//  Copyright © 2017年 qinwh2008. All rights reserved.
//

#import "SegmentsController.h"

@interface SegmentsController ()<UIScrollViewDelegate>
{
    int vcCount;
    UISegmentedControl *segmentedControl;
    UIScrollView *theScroll;
}
@end

@implementation SegmentsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad!!!!!!!");
}
- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    vcCount = (int)_viewControllers.count;
    [self initSegment];
    [self initScroolView];
    [self initSubViewController];
    NSLog(@"set controller!!!");
}

- (void)setDisableUserDrag:(BOOL)disableUserDrag
{
    _disableUserDrag = disableUserDrag;
    theScroll.scrollEnabled = !disableUserDrag;
}

- (void)initSegment
{
    if (segmentedControl) {
        [segmentedControl removeFromSuperview];
        [theScroll removeFromSuperview];
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:vcCount];
    for (int i = 0; i < vcCount; i++) {
        UIViewController *vc = _viewControllers[i];
        if (vc.title) {
            [items addObject:vc.title];
        }
    }
    segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.tintColor = kThemeColor;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentValueChanged) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

- (void)initScroolView
{
    theScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    theScroll.pagingEnabled = YES;
    theScroll.delegate = self;
    [theScroll setContentSize:CGSizeMake(self.view.frame.size.width * vcCount, theScroll.frame.size.height)];
    theScroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
    theScroll.scrollEnabled = !_disableUserDrag;
    [self.view addSubview:theScroll];
}

- (void)initSubViewController
{
    for (int i = 0; i < vcCount; i++) {
        UIViewController *vc = _viewControllers[i];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
        [theScroll addSubview:vc.view];
    }
}

- (void)segmentValueChanged
{
    [theScroll setContentOffset:CGPointMake(segmentedControl.selectedSegmentIndex * self.view.frame.size.width, 0) animated:YES];
}

#pragma mark ---------- scrollView Delegate -----------------

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offX = theScroll.contentOffset.x;
    int cur_page = offX/self.view.frame.size.width;
    segmentedControl.selectedSegmentIndex = cur_page;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
