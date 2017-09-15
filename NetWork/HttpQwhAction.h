//
//  HttpQwhAction.h
//  com.shenzhou.edu
//
//  Created by qinwh2008 on 16/12/29.
//  Copyright © 2016年 qinwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseAction.h"

@class QWHNotiModel;

@interface HttpQwhAction : NSObject

/**
 登录接口

 @param account 用户名
 @param pass 密码
 @param block 回调
 */
+(void)loginAppWithAccount:(NSString *)account password:(NSString *)pass complete:(HttpCompleteBlock)block;


/**
 检测版本
 @param block nil
 */
+(void)checkAppVersionComplete:(HttpCompleteBlock)block;


/**
 发送登录日志

 @param jsonPamars json参数
 @param block nil
 */
+(void)sendLoginLogWithPamars:(NSString *)jsonPamars Complete:(HttpCompleteBlock)block;



/**
 发送模块日志

 @param jsonPamars json参数
 @param block nil
 */
+(void)sendModuleLogWithPamars:(NSString *)jsonPamars Complete:(HttpCompleteBlock)block;



/**
 根据角色id请求相应的模块权限

 @param roleId 角色id
 @param block nil
 */
+(void)requestModulesByRoleId:(NSInteger)roleId complete:(HttpCompleteBlock)block;


/**
 根据角色id请求所管理的班级信息

 @param roleId 角色id
 @param block nil
 */
+(void)requestUnitsByRoleId:(NSInteger)roleId complete:(HttpCompleteBlock)block;


/**
 查询当前学校部门信息

 @param block nil
 */
+(void)requestDeptsOfCurrentSchoolComplete:(HttpCompleteBlock)block;


/**
 取消通知公告在报平安设备上的显示
 
 @param noticeId 通知公告id
 @param block nil
 */
+(void)requestCancelDeviceShowWithNoticeId:(NSInteger)noticeId Complete:(HttpCompleteBlock)block;


/**
 发送通知公告

 @param jsonPamars 最终拼接成的json
 @param block nil
 */
+(void)sendNoticeWithPamars:(NSString *)jsonPamars Complete:(HttpCompleteBlock)block;


/**
 请求人员列表，用在通讯录及选择人员信息功能；

 @param itemId 项目Id
 @param type 项目类型 3：学校；4：部门（班级）  若type==3，请求学校下的部门；若为4，则请求部门下的老师；
 @param teacher 是否是老师相关,否则就是学生；
 @param block nil
 */
+ (void)requestAddressListWithItemId:(NSInteger)itemId type:(int)type isStudent:(BOOL)student schoolId:(NSInteger)schoolId authKey:(NSString *)authKey Complete:(HttpCompleteBlock)block;


/**
 请求通讯录个人资料详情

 @param userId 用户id
 @param userType 用户类型
 
 */
+ (void)requestAddressDetailWithUserId:(NSInteger)userId userType:(int)userType Complete:(HttpCompleteBlock)block;


/**
 搜索通讯录(单园)

 @param keyword 关键词
 @param schoolId 学校id
 @param student 是否学生
 @param eduUnitIds 班级ids,
 @param block nil
 */
+ (void)searchAddressListWithKeyword:(NSString *)keyword schoolId:(NSInteger)schoolId isStudent:(BOOL)student eduUnitIds:(NSString *)eduUnitIds Complete:(HttpCompleteBlock)block;


/**
 搜索通讯录(所有园)

 @param keyword 关键词
 @param schoolIds 学校ids
 @param student 是否学生
 @param block nil
 */
+ (void)searchAddressListWithKeyword:(NSString *)keyword schoolIds:(NSString *)schoolIds isStudent:(BOOL)student Complete:(HttpCompleteBlock)block;


/**
 获取首页消息列表

 @param block nil
 */
+ (void)requestModuleSmsDataComplete:(HttpCompleteBlock)block;


/**
 获取通知公告列表

 @param page 第几页
 @param pagesize 页大小
 @param isMySend 是否我发送的
 @param block nil
 */
+ (void)requestNoticeListWithPage:(int)page pageSize:(int)pagesize isMySend:(BOOL)isMySend complete:(HttpCompleteBlock)block;


/**
 获取通知公告详情

 @param notiId 通知id
 @param block nil
 */
+ (void)requestNoticeDetailWithNotiId:(NSInteger)notiId complete:(HttpCompleteBlock)block;


/**
 使通知公告已读；

 @param notiModel 通知实体
 */
+ (void)makeNotiReadRequest:(QWHNotiModel *)notiModel;


/**
 获取通知公告接收对象列表

 @param page
 @param pagesize
 @param notiId 通知ID
 @param block nil
 */
+ (void)requestNoticeReceiversWithPage:(int)page pageSize:(int)pagesize notiId:(long long)notiId complete:(HttpCompleteBlock)block;


/**
 插入财务管理数据

 @param jsonPamars pamars
 @param isPayment 是否是支出；
 @param block nil
 */
+(void)insertFinanceDataWithPamars:(id)jsonPamars isPayment:(BOOL)isPayment complete:(HttpCompleteBlock)block;


/**
 获取财务支出/收入项目

 @param type 2,支出;1,收入
 @param block nil
 */
+ (void)requestFinanceItemsWithType:(int)type complete:(HttpCompleteBlock)block;

/**
 获取班级下的空气净化器；
 
 @param unitIds 班级ids，
 @param block nil
 */
+ (void)requestAirDevicesWithUnitIds:(NSString *)unitIds complete:(HttpCompleteBlock)block;

/**
 获取班级下的空气净化器；
 
 @param deviceId 设备id，
  @param cityCode 城市编码，
 @param block nil
 */
+ (void)requestWeatherWithDevice:(NSString *)deviceId cityCode:(NSString *)cityCode complete:(HttpCompleteBlock)block;


/**
 获取学校下的空净场景；

 @param schoolId 学校ID
 @param block nil
 */
+ (void)queryScenes:(int)schoolId complete:(HttpCompleteBlock)block;

/**
 获取空净场景明细；
 
 @param sceneId 场景ID
 @param block nil
 */
+ (void)queryScenesDetail:(NSInteger)sceneId complete:(HttpCompleteBlock)block;

/**
 获取空净场景明细；
 
 @param eduUnitIds 班级ID
 @param block nil
 */
+ (void)queryEduOfAirDevices:(NSString *)eduUnitIds complete:(HttpCompleteBlock)block;

/**
 删除空净场景；
 
 @param sceneId 场景ID
 @param block nil
 */
+ (void)deleteScene:(NSInteger)sceneId complete:(HttpCompleteBlock)block;

/**
 编辑空净场景；
 
 @param paramStr 场景json
 @param block nil
 */
+ (void)editScene:(id)paramStr complete:(HttpCompleteBlock)block;

/**
 添加空净场景；
 
 @param paramStr 场景json
 @param block nil
 */
+ (void)addScene:(id)paramStr complete:(HttpCompleteBlock)block;

/**
 更改空净场景开启状态；
 
 @param paramStr 场景json
 @param block nil
 */
+ (void)changeSceneStatus:(id)paramStr complete:(HttpCompleteBlock)block;
@end
