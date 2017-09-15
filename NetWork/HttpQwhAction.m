//
//  HttpQwhAction.m
//  com.shenzhou.edu
//
//  Created by qinwh2008 on 16/12/29.
//  Copyright © 2016年 qinwenhua. All rights reserved.
//

#import "HttpQwhAction.h"
#import "QWHNotiModel.h"
@implementation HttpQwhAction


+(void)loginAppWithAccount:(NSString *)account password:(NSString *)pass complete:(HttpCompleteBlock)block
{
    
    NSString *mothed=[NSString stringWithFormat:@"phone=%@&password=%@",account,pass];
    
    NSString *path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/login/loginVerifying.do?"];
    
//    NSString *path=[NSString stringWithFormat:@"http://192.168.2.73:8088/EducationInformation/%@",@"interface/login/loginVerifying.do?"];

    NSString *url=[NSString stringWithFormat:@"%@%@",path,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)checkAppVersionComplete:(HttpCompleteBlock)block
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/login/getNewUpdate.do?appFlag=16&oldVer=%d",kHttpSer_new,pub.appVer];

    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}


+(void)requestModulesByRoleId:(NSInteger)roleId complete:(HttpCompleteBlock)block
{
    NSString *mothed=[NSString stringWithFormat:@"platform=16&roleid=%ld&appVer=%d",(long)roleId,pub.appVer];
    
    NSString *path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/login/getRoleModuleButtonByRoleId.do?"];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",path,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}


+(void)requestCancelDeviceShowWithNoticeId:(NSInteger)noticeId Complete:(HttpCompleteBlock)block
{
    NSString *mothed=[NSString stringWithFormat:@"noticeid=%ld",(long)noticeId];
    
    NSString *path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/notice/cancelDeviceShow.do?"];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",path,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)sendNoticeWithPamars:(NSString *)jsonPamars Complete:(HttpCompleteBlock)block
{
    NSString *url=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/notice/saveNotice.do"];
    
    [HttpBaseAction postRequestData:jsonPamars url:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)requestAddressListWithItemId:(NSInteger)itemId type:(int)type isStudent:(BOOL)student schoolId:(NSInteger)schoolId authKey:(NSString *)authKey Complete:(HttpCompleteBlock)block
{
    NSString *mothed=[NSString stringWithFormat:@"itemId=%ld&type=%d&schoolId=%ld",(long)itemId,type,(long)schoolId];
    if (![pub isBlankString:authKey]) {
        mothed = [mothed stringByAppendingFormat:@"&btnCode=%@",authKey];
    }
    NSString *path;
    if (!student) {
        path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/addressList/queryTeaAddList.do?"];
    }else{
        path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/addressList/queryStuAddList.do?"];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",path,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)requestAddressDetailWithUserId:(NSInteger)userId userType:(int)userType Complete:(HttpCompleteBlock)block
{
    NSString *urlStr;
    if (userType == 1) {
        urlStr = [NSString stringWithFormat:@"%@interface/addressList/getTeaAddListDetail.do?teacherId=%ld",kHttpSer_new,(long)userId];
    }else{
        urlStr = [NSString stringWithFormat:@"%@interface/addressList/getAddListDetail.do?studentid=%ld",kHttpSer_new,(long)userId];
    }
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)searchAddressListWithKeyword:(NSString *)keyword schoolId:(NSInteger)schoolId isStudent:(BOOL)student eduUnitIds:(NSString *)eduUnitIds Complete:(HttpCompleteBlock)block
{
    NSString *mothed=[NSString stringWithFormat:@"keyword=%@&schoolId=%ld",keyword,(long)schoolId];
    
    NSString *path;
    if (!student) {
        path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/addressList/searchTeacher.do?"];
    }else{
        mothed = [mothed stringByAppendingFormat:@"&eduUnitId=%@",eduUnitIds];
        path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/addressList/searchStudent.do?"];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",path,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)searchAddressListWithKeyword:(NSString *)keyword schoolIds:(NSString *)schoolIds isStudent:(BOOL)student Complete:(HttpCompleteBlock)block
{
    NSString *mothed=[NSString stringWithFormat:@"keyword=%@&schoolId=%@",keyword,schoolIds];
    
    NSString *path;
    if (!student) {
        path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/addressList/searchTeacher.do?"];
    }else{
        path=[NSString stringWithFormat:@"%@%@",kHttpSer_new,@"interface/addressList/searchStudent.do?"];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",path,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}


+(void)sendLoginLogWithPamars:(NSString *)jsonPamars Complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/log/addLoginlog.do",kHttpSer_new];
    
    [HttpBaseAction postRequestData:jsonPamars url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)sendModuleLogWithPamars:(NSString *)jsonPamars Complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/log/addModulelog.do",kHttpSer_new];
    
    [HttpBaseAction postRequestData:jsonPamars url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}


+ (void)requestNoticeDetailWithNotiId:(NSInteger)notiId complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/notice/getNoticeDetail.do?noticeid=%ld",kHttpSer_new,(long)notiId];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}


+ (void)requestNoticeReceiversWithPage:(int)page pageSize:(int)pagesize notiId:(long long)notiId complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/notice/getReceiveObjs.do?noticeid=%lld&pageNo=%d&pageSize=%d",kHttpSer_new,notiId,page,pagesize];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)insertFinanceDataWithPamars:(id)jsonPamars isPayment:(BOOL)isPayment complete:(HttpCompleteBlock)block
{
    NSString *urlStr;
    if (isPayment) {
        urlStr = [NSString stringWithFormat:@"%@interface/finance/addExpenditure.do",kHttpSer_new];

    }else{
        urlStr = [NSString stringWithFormat:@"%@interface/finance/batchInsertCharge.do",kHttpSer_new];
    }
    
    [HttpBaseAction postRequestData:jsonPamars url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}


+ (void)requestAirDevicesWithUnitIds:(NSString *)unitIds complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/queryAirDevices.do?eduUnitIds=%@",kHttpSer_new,unitIds];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)requestWeatherWithDevice:(NSString *)deviceId cityCode:(NSString *)cityCode complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/queryAirQuality.do?deviceId=%@&weathercode=%@",kHttpSer_new,deviceId,cityCode];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)queryScenes:(int)schoolId complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/queryScenes.do?schoolId=%d",kHttpSer_new,schoolId];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)queryScenesDetail:(NSInteger)sceneId complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/queryScenesDetail.do?sceneid=%zd",kHttpSer_new,sceneId];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)queryEduOfAirDevices:(NSString *)eduUnitIds complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/queryEduOfAirDevices.do?eduUnitIds=%@",kHttpSer_new,eduUnitIds];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)deleteScene:(NSInteger)sceneId complete:(HttpCompleteBlock)block
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/deleteScene.do",kHttpSer_new];
    NSDictionary *jsonPamars = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",sceneId],@"sceneid", nil];

    [HttpBaseAction postRequest:jsonPamars url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)editScene:(id)paramStr complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/editScene.do",kHttpSer_new];
    
    [HttpBaseAction postRequest:paramStr url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)addScene:(id)paramStr complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/addScene.do",kHttpSer_new];
    
    [HttpBaseAction postRequest:paramStr url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)changeSceneStatus:(id)paramStr complete:(HttpCompleteBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@interface/air/changeSceneStatus.do",kHttpSer_new];
    
    [HttpBaseAction postRequest:paramStr url:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+ (void)requestNoticeListWithPage:(int)page pageSize:(int)pagesize isMySend:(BOOL)isMySend complete:(HttpCompleteBlock)block
{
    //userId=564875&schoolId=2859&deptId=6880
    NSString *urlStr;
    if (isMySend) {
        urlStr = [NSString stringWithFormat:@"%@interface/notice/querySendNoticeListss.do?userId=%d&pageNo=%d&pageSize=%d",kHttpSer_new,564875,page,pagesize];
    }else
        urlStr = [NSString stringWithFormat:@"%@interface/notice/queryNoticeListss.do?userId=%d&schoolId=%d&deptId=%d&pageNo=%d&pageSize=%d",kHttpSer_new,564875,2859,6880,page,pagesize];
    
    [HttpBaseAction getRequest:urlStr complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

/*
[HttpQwhAction requestWeatherWithDevice:_airDevice.deviceid cityCode:_airDevice.weathercode complete:^(id result, NSError *error) {
    if (error == nil && result) {
        
        if ([result[@"rtnCode"] intValue] == 10000) {
            NSArray *arr = result[@"rtnData"];
            [self refreshWeatherUIWithDic:arr.firstObject];
        }
        NSLog(@"请求天气成功！%@",result);
        
    }else{
        NSLog(@"请求天气失败！");
    }
}];
*/

@end
