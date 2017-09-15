//
//  QWHPublic.m
//  lbt_jz_ios_client
//
//  Created by wenhuaqin on 14-6-11.
//  Copyright (c) 2014年 qinwenhua. All rights reserved.
//

#import "QWHPublic.h"
#import "OpenUDID.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#include <sys/sysctl.h>


@implementation QWHPublic

- (id)init
{
    self = [super init];
    if (self) {
    }
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];

    _phoneModel = platform;
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    _appVer = [[dicInfo objectForKey:@"CFBundleVersion"] intValue];
    UIDevice *devi = [UIDevice currentDevice];
    _sysVer = [devi systemVersion];
    _IMSI = [OpenUDID value];

    _formatter0 = [[NSDateFormatter alloc] init];
    _formatter1 = [[NSDateFormatter alloc] init];
    _formatter2 = [[NSDateFormatter alloc] init];
    _formatter3 = [[NSDateFormatter alloc] init];
    _formatter4 = [[NSDateFormatter alloc] init];
    _formatter5 = [[NSDateFormatter alloc] init];
    _formatter6 = [[NSDateFormatter alloc] init];
    _formatter7 = [[NSDateFormatter alloc] init];
    _formatter8 = [[NSDateFormatter alloc] init];

    [_formatter0 setDateFormat:@"yyyy-MM-dd"];
    [_formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    [_formatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [_formatter3 setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    [_formatter4 setDateFormat:@"MM-dd HH:mm"];
    [_formatter5 setDateFormat:@"yyyy"];
    [_formatter6 setDateFormat:@"yyyy年MM月"];
    [_formatter7 setDateFormat:@"HH:mm"];
    [_formatter8 setDateFormat:@"yyyy-MM"];

    return self;
}
- (BOOL)isNeedLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastLoginDate = [defaults objectForKey:@""];
    
    if (!lastLoginDate) {  //无日期，需要重要登录；
        
        return YES;
    }else{                //有日期，且小于5天内，无需登录；
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        NSDate *compareDate = [formatter dateFromString:lastLoginDate];
        NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
        timeInterval = -timeInterval;
        
        if (timeInterval < 60 * 60 * 24 * 5) {   //距上次5天内自动登录；
            return NO;
        }else{
            return YES;
        }
    }
}


- (NSString *)compareCurrentTime:(NSString *)dateStr
{
    NSLog(@"lineTime = %@",dateStr);
    if ([self isBlankString:dateStr]) {
        return @"未知时间";
    }
    NSDateFormatter *formatter;
    
    if (dateStr.length < 17) {
        formatter = _formatter1;
    }else if(dateStr.length > 20){
        formatter = _formatter3;;
    }else{
        formatter = _formatter2;
    }
    
    NSDate *compareDate = [formatter dateFromString:dateStr];
    NSString *normalago = [_formatter4 stringFromDate:compareDate];
    
    //较久时间，昨天以前；显示年月日
    NSString *longago = [_formatter1 stringFromDate:compareDate];
    NSString *msgYear = [_formatter5 stringFromDate:compareDate];
    NSString *thisYear = [_formatter5 stringFromDate:[NSDate date]];
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    if (timeInterval > 0) {
        timeInterval = 0;
    }
    timeInterval = fabs(timeInterval);
    long temp = 0;
    NSString *result;
    
    if (![msgYear isEqualToString:thisYear]) {  //非同一年；
        return longago;
    }
    
    if (timeInterval < 60) {   //一分钟内；
        result = [NSString stringWithFormat:@"刚刚"];
    }else if((temp = timeInterval/60) <60){   //一小时内；
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if((temp = temp/60) <24){  //一天内；
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }else{
        result = normalago;
    }
    return result;
}

- (void)createDirectory
{
//以用户id为每个用户创建文件夹：
    NSString *imageDir = [NSString stringWithFormat:@"%@/caches", DocumentPath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    self.userDocumentPath = [NSString stringWithFormat:@"%@/",imageDir];
}

- (BOOL)isBlankString:(NSString *)string{   //判断文本是否为空或空格；
    
    if ([string isKindOfClass:[NSString class]] && string.length > 0 && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}
- (NSString *)removeWitheSpace:(NSString *)foreString
{
    if ([self isBlankString:foreString]) {
        return nil;
    }
    NSString *strUrl = [foreString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([self isBlankString:strUrl]) {
        return nil;
    }
    return strUrl;
}
- (NSString*)getCurrentTimeString
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmssSS"];
    NSString *timeStr = [dateformat stringFromDate:[NSDate date]];
    
    return timeStr;
}

- (float)heightByString:(NSString *)tstring width:(int)width fontsize:(int)fSize
{
    if ([self isBlankString:tstring]) {
        return 0.0;
    }
    UIFont * tfont = [UIFont systemFontOfSize:fSize];
    CGSize size =CGSizeMake(width,MAXFLOAT);
    
    CGSize actualsize;
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
    return actualsize.height + 1;
}

- (float)heightByString:(NSString *)tstring
{
    if ([self isBlankString:tstring]) {
        return 0.0;
    }
    UIFont * tfont = [UIFont systemFontOfSize:15];
    CGSize size =CGSizeMake((ScreenWidth - 70),MAXFLOAT);
    
    CGSize actualsize;
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    actualsize = [tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    return actualsize.height;
}

//ZDH文本高度
- (float)ZDHCellHeightByString:(NSString *)tstring
{
    if ([self isBlankString:tstring]) {
        return 0.0;
    }
    
    UIFont * tfont = [UIFont systemFontOfSize:17.0];
    CGSize size =CGSizeMake((ScreenWidth - 16),MAXFLOAT);
    
    CGSize actualsize;
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    return actualsize.height;
}


- (long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (NSString *)formatSize:(long long)theSize
{
    if (theSize <= 0) {
        return @"0KB";
    }else if (theSize < 1024) {
        return [NSString stringWithFormat:@"%lldB",theSize];
    }else if (theSize < 1024*1024){
        return [NSString stringWithFormat:@"%lldKB",theSize/1024];
    }else if (theSize < 1024*1024*1024){
        return [NSString stringWithFormat:@"%.1fM",(float)theSize/1024/1024];
    }else {
        return [NSString stringWithFormat:@"%.1fG",(float)theSize/1024/1024/1024];
    }
}

- (UIColor *)getRandomColor
{
    NSArray *colors = [NSArray arrayWithObjects:kRedColor,kGreenColor,kYellowColor,kOrangeColor,kMagentaColor,kBlueColor, nil];
    //生成0到x-1之间的随机正整数;
    int value = arc4random() % colors.count;
    return colors[value];
}


- (BOOL)compareHourAndMinute:(NSString *)beginDate endDate:(NSString*)endDate{
    
    int hour_1=[(NSNumber*)[beginDate substringToIndex:2]intValue];
    int minute_1=[(NSNumber*)[beginDate substringFromIndex:3]intValue];
    int hour_2=[(NSNumber*)[endDate substringToIndex:2]intValue];
    int minute_2=[(NSNumber*)[endDate substringFromIndex:3]intValue];
    
    if (hour_1>hour_2) {
        return NO;
    }else if (hour_1==hour_2){
        if (minute_1>=minute_2) {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)listTheImgs:(NSArray *)imgsNames and:(NSArray *)titles byLeft:(int)jianGe_left top:(int)jianGe_top JianGe:(int)jianGe lieShu:(int)lieShu labHight:(int)labH inView:(UIView *)targatView vc:(UIViewController *)targatVC isImgLocal:(BOOL)isLocal fondSize:(int)fondSize
{
    int jiangeOfimgandtext = 5;
    if (!titles || titles.count == 0) {
        jiangeOfimgandtext = 0;
    }
    int imgW = (ScreenWidth - jianGe_left*2 - jianGe*(lieShu - 1))/lieShu;
    
    for (int i = 0; i < imgsNames.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(jianGe_left + fmod(i, lieShu)*(imgW + jianGe), jianGe_top + (jianGe + imgW + labH)*(i/lieShu), imgW, imgW);
        btn.tag  = i;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.imageView.clipsToBounds = YES;

//        btn.layer.cornerRadius = imgW/2;
//        btn.layer.borderColor = kThemeColor.CGColor;
//        btn.layer.borderWidth = 0.5;
//        btn.layer.masksToBounds = YES;
        if (targatVC) {
            btn.userInteractionEnabled  = YES;
//            [btn addTarget:targatVC action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            btn.userInteractionEnabled = NO;
        }
        if (isLocal) {
            [btn setImage:[UIImage imageNamed:imgsNames[i]] forState:UIControlStateNormal];
        }else{
//            [btn setImageWithURL:[NSURL URLWithString:imgsNames[i]] forState:UIControlStateNormal placeholderImage:kHeaderImg];
        }
        if (titles) {
            UILabel *lab = [[UILabel alloc] init];
            lab.frame = CGRectMake(jianGe_left + fmod(i, lieShu)*(imgW + jianGe), jianGe_top + imgW + jiangeOfimgandtext+ (jianGe + imgW + labH)*(i/lieShu), imgW, labH);
            lab.text = titles[i];
            lab.textColor = kBlackColor;
            lab.font = [UIFont systemFontOfSize:fondSize];
            lab.textAlignment = NSTextAlignmentCenter;
            [targatView addSubview:btn];
            [targatView addSubview:lab];
        }
    }
}


- (void)showAlertWithString:(NSString *)content
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    alert.tintColor = kThemeColor;
    [alert show];
}
- (void)showAlertViewWithStr:(NSString *)content cancelBtn:(NSString *)cancelBtn sureBtn:(NSString *)sureBtn delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:content delegate:delegate cancelButtonTitle:cancelBtn otherButtonTitles:sureBtn, nil];
    alert.tintColor = kThemeColor;
    [alert show];
}

- (void)showRequestErrorCode:(int)rtnCode
{
    NSString *rtnDesc;
    if(rtnCode == 10001){
        rtnDesc = @"返回失败";
    }else if(rtnCode == 10002){
        rtnDesc = @"暂无数据";
    }else if(rtnCode == 10003){
        rtnDesc = @"接口响应失败";
    }else if(rtnCode == 10004){
        rtnDesc = @"用户无角色";
    }else if(rtnCode == 10101){
        rtnDesc = @"用户名或密码错误";
    }else if(rtnCode == 10102){
        rtnDesc = @"用户名或密码为空";
    }else if(rtnCode == 10103){
        rtnDesc = @"您的客户端版本过低，必须要升级之后，才可以登录";
    }else if(rtnCode == 10006){
        rtnDesc = @"您输入的内容包含敏感词，请重新编辑后发送";
    }else{
       rtnDesc = @"请求异常，再试一下吧";
    }
//    [SVProgressHUD showErrorWithStatus:rtnDesc];
}
- (int)checkResponse:(NSDictionary *)response alertView:(UIView *)aview
{
    NSLog(@"pubcheck response = %@",response);

    if (response && [response isKindOfClass:[NSDictionary class]]){
        int rtnCode = [response[@"rtnCode"] intValue];
        NSString *rtnDesc;
        if (rtnCode == 10000 || rtnCode == 10002) {    //请求成功；
            return rtnCode;
        }else if(rtnCode == 10001){
            rtnDesc = @"返回失败";
        }else if(rtnCode == 10003){
            rtnDesc = @"接口响应失败";
        }else if(rtnCode == 10004){
            rtnDesc = @"用户无角色";
        }else if(rtnCode == 10101){
            rtnDesc = @"用户名或密码错误";
        }else if(rtnCode == 10102){
            rtnDesc = @"用户名或密码为空";
        }else if(rtnCode == 10103){
            rtnDesc = @"您的客户端版本过低，必须要升级之后，才可以登录";
        }else if(rtnCode == 10006){
            rtnDesc = @"您输入的内容包含敏感词，请重新编辑后发送";
        }else{
            rtnDesc = @"请求失败";
        }
        if (aview) {
//            [MBProgressHUD showError:rtnDesc toView:aview];
        }
    }
    return 0;
}
- (void)formatCellTextLabel:(UILabel *)lab
{
    lab.textColor = kBlackColor;
    lab.font = [UIFont systemFontOfSize:15];
}
- (void)formatCellDetailLabel:(UILabel *)lab
{
    lab.textColor = kLightGreyColor;
    lab.font = [UIFont systemFontOfSize:14];
}
- (float)widthByString:(NSString *)tString fontsize:(int)fSize
{
    UIFont * tfont = [UIFont systemFontOfSize:fSize];
    CGSize size =CGSizeMake((ScreenWidth - 30),MAXFLOAT);
    
    CGSize actualsize;
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    actualsize = [tString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.width;
    
}
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


- (UILabel *)placeLabelInView:(UIView *)view withFrame:(CGRect)rect
{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    if (view) {
        [view addSubview:lab];
    }
    return lab;
}
- (UILabel *)placeLabelInView:(UIView *)view withFrame:(CGRect)rect withText:(NSString *)string
{
    UILabel *lab = [self placeLabelInView:view withFrame:rect];
    lab.text = string;
    return lab;
}
- (UILabel *)placeLabelInView:(UIView *)view withFrame:(CGRect)rect withText:(NSString *)string andTextColor:(UIColor *)color andFont:(UIFont *)font andAlignment:(NSTextAlignment)alignment
{
    UILabel *lab = [self placeLabelInView:view withFrame:rect withText:string];
    lab.textColor = color;
    lab.font = font;
    lab.textAlignment = alignment;
    return  lab;
}
- (UIImageView *)placeImgViewInView:(UIView *)view withFrame:(CGRect)rect  withImageStr:(NSString *)imageStr
{
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:rect];
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    imgv.clipsToBounds = YES;
    if (imageStr) {
        if ([imageStr hasPrefix:@"http"]) {
//            [imgv setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:kPlaceholder];
        }else{
            imgv.image = [UIImage imageNamed:imageStr];
        }
    }
    [view addSubview:imgv];
    
    return imgv;
}
- (UIButton *)placeButtonInView:(UIView *)view withFrame:(CGRect)rect withTitle:(NSString *)title orImg:(NSString *)imgname
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [view addSubview:btn];
    
    if (title) {
        btn.titleLabel.font = Font(15);
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (imgname) {
        [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    }
    return btn;
}

- (NSString *)stringByClearBlanksplace:(NSString *)targetStr
{
    if (![targetStr isKindOfClass:[NSString class]]) {
        return @"";
    }
    return  [targetStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(UILabel *)createLabelFrame:(CGRect)frame color:(UIColor*)color font:(UIFont *)font text:(NSString *)text{
    
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.font=font;
    label.textColor=color;
    label.textAlignment=NSTextAlignmentLeft;
    label.text=text;
    
    return label;
}

-(UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder{
    
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    textField.placeholder=placeholder;
    
    return textField;
}
@end
