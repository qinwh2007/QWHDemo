//
//  DemoDetailVC.m
//  QWHTest
//
//  Created by qinwh2008 on 2017/9/14.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "DemoDetailVC.h"

@interface DemoDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic) UITableView *theTable;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation DemoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"subAnimation";
    self.view.backgroundColor = _color;
    [self initTableView];
}

- (void)initTableView
{
    _theTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _theTable.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _theTable.dataSource = self;
    _theTable.delegate = self;
    _theTable.backgroundColor = kWhiteColor;
    [self.view addSubview:_theTable];
}

#pragma mark - -------- TableView data source & TableView delegate --------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *adifier = @"firCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adifier];
    }
    cell.backgroundColor = [pub getRandomColor];
    cell.textLabel.text = @"中国移动通信呵呵";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
