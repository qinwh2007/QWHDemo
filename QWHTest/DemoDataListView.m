//
//  DemoDataListView.m
//  QWHDemo
//
//  Created by qinwh2008 on 2017/9/12.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "DemoDataListView.h"

#import "QWHNotiModel.h"
#import "DemoCell.h"
#import "DemoDetailVC.h"
@interface DemoDataListView ()<UITableViewDataSource,UITableViewDelegate>
{
    int page;
    int pageSize;
    int responseNum;
}

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation DemoDataListView

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc] init];
    page = 0;
    pageSize = 10;
    
    self.btnTitle = @"点击重试";
    self.theTable.dataSource = self;
    self.theTable.delegate = self;
    self.theTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.theTable addHeaderWithTarget:self action:@selector(getData)];
    [self.theTable addFooterWithTarget:self action:@selector(getMoreData)];
    [self getData];
}

-(void)buttonEvent
{
    [self getData];
}

- (void)getData
{
    page = 0;
    if (_dataArr.count == 0) {
        [WBLoadingView showLoadingInView:self.view];
    }
    [self makeRequest];
}

- (void)getMoreData
{
    page = (int)(_dataArr.count + pageSize - 1)/pageSize;
    [self makeRequest];
}

- (NSArray *)formatTestDataWithPage:(int)curpage size:(int)size
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [NSThread sleepForTimeInterval:0.5];
    if (curpage > 0) {
        size = 2;
    }
    for (int i = 0; i < size; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1160",@"noticeid",@"中国移动通信呵呵",@"title",@"几斤几两",@"content",@"2017-09-08 16:17",@"sendtime",@"贺宁宁",@"senderName",@"园长",@"senderRole",@"1",@"read",@"0",@"deviceShow",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4187763753,1613150197&fm=27&gp=0.jpg",@"senderPhoto", nil];
        [arr addObject:dic];
    }
    return arr;
}

- (void)makeRequest
{
    [HttpQwhAction requestNoticeListWithPage:page pageSize:pageSize isMySend:0 complete:^(id result,NSError *error){
        
        if (!error) {
            [self handleResponseError:error.code];
        }else{
            
            __async_opt__^{
                
                NSArray *arr = [self formatTestDataWithPage:page size:pageSize];
                responseNum = (int)arr.count;

                if (page == 0) {
                    [_dataArr removeAllObjects];
                }
                [_dataArr addObjectsFromArray:[QWHNotiModel mj_objectArrayWithKeyValuesArray:arr]];
                __async_main__^{
                    [self requestDone];
                });
            });
        }
    }];
    
    
    /*
    [HttpQwhAction requestNoticeListWithPage:page pageSize:pageSize isMySend:_isSend complete:^(id result,NSError *error){
     
        if (error) {
            [self handleResponseError:error.code];
        }
        
        if ([pub checkResponse:result alertView:self.view] == 10000) {
            NSArray *arr = result[@"rtnData"];
            if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                responseNum = (int)arr.count;
                
                if (page == 0) {
                    [_dataArr removeAllObjects];
                    [self addRefreshTool];
                }
                __async_opt__^{
                    [self packListData:arr];
                    
                    __async_main__^{
                        [self displayLineDatas];
                    });
                });
                return;
            }
            responseNum = 0;
            if (page == 0) {  //刷新无数据时清空列表；
                [self.dataArr removeAllObjects];
                [self.theTable reloadData];
//                self.theTable.descriptionText = @"暂无数据";
//                self.theTable.loading = NO;
            }
            [self requestDone];
        }
     
    }];
     */
}

- (void)handleResponseError:(NSInteger)errCode
{
    if(errCode == -1011){
        if (!_dataArr.count) {
            self.noDataImgName = @"NoData";
            self.noDataTitle = @"服务器开小差了，稍候再来吧";
            [self.theTable reloadEmptyDataSet];
        }
    }else if(errCode == -1001){
        if (!_dataArr.count) {
            self.noDataImgName = @"NoData";
            self.noDataTitle = @"请求超时了，稍候再来吧";
            [self.theTable reloadEmptyDataSet];
        }
    }else if(errCode == -1009){
        if (!_dataArr.count) {
            self.noDataImgName = @"NoOrderData";
            self.noDataTitle = @"世界上最遥远在距离就是断网";
            [self.theTable reloadEmptyDataSet];
        }
    }
    [self requestDone];
}

- (void)requestDone
{
    [self.theTable headerEndRefreshing];
    
    if (self.theTable.isFooterRefreshing) {
        [self.theTable endRefreshingWithNoMoreData];
    }
    
    if (responseNum < pageSize) {
        [self.theTable endRefreshingWithNoMoreData];
    }else{
        [self.theTable reSetFooterNoMoreData];
    }
    
    [self.theTable reloadData];
    [WBLoadingView hideLoadingForView:self.view];
}


#pragma mark - -------- TableView data source & TableView delegate --------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *adifier = @"firCell";
    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:adifier];
    if (cell == nil) {
        cell = [[DemoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.notiModel = _dataArr[indexPath.section];
    cell.theIndexpath = indexPath;
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
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCell *cell = (DemoCell *)[tableView cellForRowAtIndexPath:indexPath];
    DemoDetailVC *vc = [[DemoDetailVC alloc] init];
    vc.color = cell.backgroundColor;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --------------tableView Edit------------

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteActionMsg:indexPath];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    return @[deleteRowAction];

}

- (void)deleteActionMsg:(NSIndexPath *)indexp
{
    [_dataArr removeObjectAtIndex:indexp.row];
    [self.theTable deleteSections:[NSIndexSet indexSetWithIndex:indexp.section] withRowAnimation:UITableViewRowAnimationLeft];
}


@end
