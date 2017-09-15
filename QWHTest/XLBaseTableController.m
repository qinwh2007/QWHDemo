//
//  XLBaseTableController.m
//  EmptyDataHandle
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 ZXL. All rights reserved.
//

#import "XLBaseTableController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface XLBaseTableController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation XLBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowEmptyData = YES;
    
    [self.view addSubview:self.theTable];
    self.theTable.backgroundColor = kWhiteColorSystem;
    self.theTable.emptyDataSetSource = self;
    self.theTable.emptyDataSetDelegate = self;
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.noDataImgName) {
        return [UIImage imageNamed:self.noDataImgName];
    }
    return [UIImage imageNamed:@"NoData"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.noDataTitle?self.noDataTitle:@"亲，暂无任何数据哦";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.noDataDetailTitle;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return self.noDataDetailTitle?[[NSAttributedString alloc] initWithString:text attributes:attributes]:nil;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.isShowEmptyData;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -self.theTable.tableHeaderView.frame.size.height/2.0f;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f]};
    
    return self.btnTitle?[[NSAttributedString alloc] initWithString:self.btnTitle attributes:attributes]:nil;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return self.btnImgName?[UIImage imageNamed:self.btnImgName]:nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self buttonEvent];
}

#pragma mark 按钮事件
-(void)buttonEvent
{
    
}

-(UITableView *)theTable
{
    if(_theTable == nil)
    {
        _theTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
        _theTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
        _theTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
        
        _theTable.showsVerticalScrollIndicator = NO;
        _theTable.showsHorizontalScrollIndicator = NO;
    }
    
    return _theTable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
