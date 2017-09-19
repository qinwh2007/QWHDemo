//
//  GlobeConst.m
//  com.shenzhou.edu
//
//  Created by qinwh2008 on 16/12/27.
//  Copyright © 2016年 qinwenhua. All rights reserved.
//

#import "GlobeConst.h"

@implementation GlobeConst

    NSString *const kUserAgeKeyTest = @"XXXXX.userAge";
    int const kCellLeft = 12;
    int const kCellTop = 18;
    int const kDistantVer = 15;
    int const kDistantHor = 8;

    int const PAGE = 0;
    int const PAGESIZE = 20;

    int const kTimeOut = 10;     //请求超时时间；
    int const kRefreshInterval = 60; //
    int const kUpladIamgeMaxCount = 9;    //每次上传最多照片个数；
    int const KHeaderSelectionHeight = 36;

    int const IMAGE_MAX_SIZE_WIDTH = 1280;          //压缩后的图片尺寸
    int const IMAGE_MAX_SIZE_GEIGHT = 720;

    int const kMoiveWidth = 640;
    int const kMoiveHeight = 480;
//默认地址；
    NSString *const kHttpSer_default = @"https://mobile.itycz.com/EducationInformation/";
    NSString *const kUserNameKey = @"user_Name";
    NSString *const kPasswordKey = @"user_Pass";
    NSString *const kLastHeader = @"lastUserHeader";
    NSString *const kSchoolId = @"kschoolid";
    NSString *const kTeacherId = @"kTeacherId";
    NSString *const kRoleId = @"kRoleId";
    NSString *const kLastDateKey = @"lastLoginDate";
@end
