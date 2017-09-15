//
//  MJRefreshTableFooterView.h
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshBaseView.h"

@interface MJRefreshFooterView : MJRefreshBaseView
+ (instancetype)footer;
/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;
@end