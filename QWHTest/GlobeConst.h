//
//  GlobeConst.h
//  com.shenzhou.edu
//
//  Created by qinwh2008 on 16/12/27.
//  Copyright © 2016年 qinwenhua. All rights reserved.
//  此文件用来统一管理全局常量；

#import <Foundation/Foundation.h>

@interface GlobeConst : NSObject

extern NSString *const kUserAgeKeyTest;

extern int const kCellLeft;
extern int const  kCellTop;
extern int const  cellRight;
extern int const  kDistantVer;
extern int const  kDistantHor;


extern int const  PAGE;
extern int const  PAGESIZE;

//默认地址；
extern NSString *const kHttpSer_default;

extern int const kTimeOut;    //请求超时时间；
extern int const kRefreshInterval; //
extern int const kUpladIamgeMaxCount;    //每次上传最多照片个数；
extern int const KHeaderSelectionHeight;

extern int const IMAGE_MAX_SIZE_WIDTH;         //压缩后的图片尺寸
extern int const IMAGE_MAX_SIZE_GEIGHT;

extern int const kMoiveWidth;
extern int const kMoiveHeight;
extern NSString *const kUserNameKey;
extern NSString *const kPasswordKey;
extern NSString *const kLastHeader;
extern NSString *const kSchoolId;
extern NSString *const kTeacherId;
extern NSString *const kRoleId;
extern NSString *const kLastDateKey;

@end
