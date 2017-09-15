//
//  QWHNotiModel.h
//  Lbt
//
//  Created by qinwh2008 on 16/6/23.
//  Copyright © 2016年 qinwh2008. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWHNotiModel : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *senderName;
@property (strong, nonatomic) NSString *senderPhoto;
@property (strong, nonatomic) NSString *senderRole;

@property (strong, nonatomic) NSString *targetName;
@property (strong, nonatomic) NSString *sendtime;
@property (strong, nonatomic) NSArray *imglist;
@property (strong, nonatomic) NSArray *fileList;
@property (assign, nonatomic) BOOL read;
@property (assign, nonatomic) long long noticeid;
@property (assign, nonatomic) BOOL deviceShow;

@property (strong, nonatomic) UIColor *color;
@end
