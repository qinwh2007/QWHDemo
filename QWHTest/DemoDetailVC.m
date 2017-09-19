//
//  DemoDetailVC.m
//  QWHTest
//
//  Created by qinwh2008 on 2017/9/14.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "DemoDetailVC.h"
#import "QWHNotiModel.h"

@interface DemoDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int page;
    int pageSize;
    int responseNum;
}
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation DemoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"subAnimation";
    self.view.backgroundColor = _color;
    [self.navigationItem setRightItemWithTarget:self action:@selector(becomeEdit) title:@"编辑"];
    self.btnTitle = @"点击重试";
    page = 0;
    pageSize = 20;
    self.theTable.dataSource = self;
    self.theTable.delegate = self;
    [self.theTable addHeaderWithTarget:self action:@selector(getData)];
    [self.theTable addFooterWithTarget:self action:@selector(getMoreData)];
    [self getData];
}

- (void)becomeEdit{
    if (!self.theTable.isEditing) {
        self.theTable.editing = YES;
        [self.navigationItem setRightItemWithTarget:self action:@selector(becomeEdit) title:@"完成"];
    }else{
        self.theTable.editing = NO;
        [self.navigationItem setRightItemWithTarget:self action:@selector(becomeEdit) title:@"编辑"];
    }
}

#pragma mark 重试按钮事件
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

- (NSArray *)formatTestDataWithPage:(int)curpage size:(int)size
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [NSThread sleepForTimeInterval:0.5];
    if (curpage > 0) {
        size = 2;
    }
    for (int i = 0; i < size; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1160",@"noticeid",@"中国移动通信呵呵",@"title",@"几斤几两",@"content",@"2017-09-08 16:17",@"sendtime",[NSString stringWithFormat:@"贺宁宁%d",i],@"senderName",@"园长",@"senderRole",@"1",@"read",@"0",@"deviceShow",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4187763753,1613150197&fm=27&gp=0.jpg",@"senderPhoto", nil];
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
                [self.dataArr addObjectsFromArray:[QWHNotiModel mj_objectArrayWithKeyValuesArray:arr]];
                __async_main__^{
                    [self requestDone];
                });
            });
        }
    }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *adifier = @"firCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adifier];
    }
    QWHNotiModel *noti = _dataArr[indexPath.row];
    cell.textLabel.text = noti.senderName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QWHNotiModel *noti = _dataArr[indexPath.row];

    FFToast *toast = [[FFToast alloc]initToastWithTitle:@"标题" message:noti.senderName iconImage:[UIImage imageNamed:@"tab_message_pre"]];
    toast.toastPosition = FFToastPositionBelowStatusBarWithFillet;
    toast.toastBackgroundColor = [UIColor colorWithRed:75.f/255.f green:107.f/255.f blue:122.f/255.f alpha:1.f];
    [toast show:^{
        //点击消息通知时调用
        NSLog(@"ok");
    }];
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
    [self.theTable deleteRowsAtIndexPaths:@[indexp] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    QWHNotiModel *targetNoti = _dataArr[fromIndexPath.row];
    [_dataArr removeObject:targetNoti];
    [_dataArr insertObject:targetNoti atIndex:toIndexPath.row];
    for (int i = 0; i < _dataArr.count ; i++) {
        QWHNotiModel *noti = _dataArr[i];
        NSLog(@"%@",noti.senderName);
    }
}

#pragma mark ---------------属性懒加载
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
