//
//  HttpBaseAction.m
//  com.shenzhou.edu
//
//  Created by company on 16/6/30.
//  Copyright © 2016年 qinwenhua. All rights reserved.
//

#import "HttpBaseAction.h"
#import "AFHTTPSessionManager.h"
#define TIMEOUTSECONDS 30

@implementation HttpBaseAction

+ (AFHTTPSessionManager *)defaultManager{
    static AFHTTPSessionManager *manager;
    @synchronized(self){
        if (manager == nil) {
            manager=[[AFHTTPSessionManager alloc]init];

            manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/xml",@"text/xml",@"text/plain",@"application/json",nil];
            // 设置请求格式
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            

            manager.requestSerializer.timeoutInterval=TIMEOUTSECONDS;

        }
    }
    return manager;
}


+ (void)postRequest:(id)parameters url:(NSString *)url complete:(HttpCompleteBlock)block{
    
    [[HttpBaseAction defaultManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *responseDictionary=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        block(responseDictionary,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];

}

+(void)getRequest:(NSString*)str complete:(HttpCompleteBlock)block{
    
    
    [[HttpBaseAction defaultManager] GET:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = [self jsonToDictionary:[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]];
        block(responseDic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        block(nil,error);
    }];
}

+ (NSDictionary *)jsonToDictionary:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&jsonError];
    return resultDic;
}

+(void)postRequestData:(NSString*)jsonStr url:(NSString *)url complete:(HttpCompleteBlock)block{

    //把传进来的URL字符串转变为URL地址
    NSURL *URL = [NSURL URLWithString:url];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:30];
    
    NSData *postData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];//请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    __block NSData *returnData;
    __block NSArray *result;
    __async_opt__^{
        
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

        __async_main__^{
            if (!returnData) {
                block(nil,nil);
                return;
            }

            result = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"打印参数:%@",result);
            
            block(result,nil);
        });
    });
}

+(AFSecurityPolicy*)customSecurityPolicy{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"certificate" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}


+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (void)downloadFileWithOption:(NSDictionary *)parameters
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
                     complete:(HttpCompleteBlock)block
                     progress:(void (^)(float progress))progress

{
 /**   AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:[requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    
    [operation start];**/
}

+ (void)uploadFileWithOption:(NSDictionary *)parameters
                 withInferface:(NSString*)url
                     savedPath:(NSData*)image
                      complete:(HttpCompleteBlock)block

{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [pub getCurrentTimeString]];
        [formData appendPartWithFileData:image
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    }success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        block(task,error);
    }];
}

@end
