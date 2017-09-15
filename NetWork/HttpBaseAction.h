//
//  HttpBaseAction.h
//  com.shenzhou.edu
//
//  Created by company on 16/6/30.
//  Copyright © 2016年 qinwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpCompleteBlock)(id result,NSError *error);

@interface HttpBaseAction : NSObject

+ (void)postRequest:(id)parameters url:(NSString *)url complete:(HttpCompleteBlock)block;

+(void)postRequestData:(NSString*)jsonStr url:(NSString *)url complete:(HttpCompleteBlock)block;


+(void)getRequest:(NSString*)str complete:(HttpCompleteBlock)block;

+ (BOOL)isBlankString:(NSString *)string;

+ (void)downloadFileWithOption:(NSDictionary *)parameters
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
                      complete:(HttpCompleteBlock)block
                      progress:(void (^)(float progress))progress;
+ (void)uploadFileWithOption:(NSDictionary *)parameters
               withInferface:(NSString*)url
                   savedPath:(NSData*)image
                    complete:(HttpCompleteBlock)block;
@end
