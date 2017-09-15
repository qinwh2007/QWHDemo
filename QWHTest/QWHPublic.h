//
//  QWHPublic.h
//  lbt_jz_ios_client
//
//  Created by wenhuaqin on 14-6-11.
//  Copyright (c) 2014年 qinwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface QWHPublic : NSObject
{

}

@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *userDocumentPath;
@property (nonatomic,retain) NSString *mainURL;

@property (assign, nonatomic) int appVer;
@property (retain, nonatomic) NSString *phoneModel;
@property (retain, nonatomic) NSString *sysVer;
@property (retain, nonatomic) NSString *IMSI;

@property (strong, nonatomic) NSDateFormatter *formatter0; //yyyy-MM-dd
@property (strong, nonatomic) NSDateFormatter *formatter1; //yyyy-MM-dd HH:mm
@property (strong, nonatomic) NSDateFormatter *formatter2; //yyyy-MM-dd HH:mm:ss
@property (strong, nonatomic) NSDateFormatter *formatter3; //yyyy-MM-dd HH:mm:ss:SSS
@property (strong, nonatomic) NSDateFormatter *formatter4; //MM-dd HH:mm
@property (strong, nonatomic) NSDateFormatter *formatter5; //yyyy
@property (strong, nonatomic) NSDateFormatter *formatter6; //yyyy年MM月
@property (strong, nonatomic) NSDateFormatter *formatter7; //HH:mm
@property (strong, nonatomic) NSDateFormatter *formatter8; //yyyy-MM


- (NSString *)compareCurrentTime:(NSString *)dateStr;
- (BOOL)isNeedLogin;                           //是否需要重新登录；
- (void)createDirectory;
- (BOOL)isBlankString:(NSString *)string;
- (NSString *)removeWitheSpace:(NSString *)foreString;

- (NSString *)getCurrentTimeString;   //根据当前时间生成字符串；
- (float)heightByString:(NSString *)tstring;
- (float)heightByString:(NSString *)tstring width:(int)width fontsize:(int)fSize;
- (float)widthByString:(NSString *)tString fontsize:(int)fSize;

- (long long)fileSizeAtPath:(NSString*)filePath;
- (NSString *)formatSize:(long long)theSize;
- (NSString *)getHttpURL;
- (UIColor *)getRandomColor;

/**
 比较两个时间的大小

 @param beginDate 开始时间
 @param endDate 结束时间
 */
- (BOOL)compareHourAndMinute:(NSString *)beginDate endDate:(NSString*)endDate;

//ZDHcell文本高度计算
- (float)ZDHCellHeightByString:(NSString *)tstring;

- (void)listTheImgs:(NSArray *)imgsNames and:(NSArray *)titles byLeft:(int)jianGe_left top:(int)jianGe_top JianGe:(int)jianGe lieShu:(int)lieShu labHight:(int)labH inView:(UIView *)targatView vc:(UIViewController *)targatVC isImgLocal:(BOOL)isLocal fondSize:(int)fondSize;

- (void)showAlertWithString:(NSString *)content;
- (void)showAlertViewWithStr:(NSString *)content cancelBtn:(NSString *)cancelBtn sureBtn:(NSString *)sureBtn delegate:(id)delegate;
- (void)showRequestErrorCode:(int)rtnCode;
- (int)checkResponse:(NSDictionary *)response alertView:(UIView *)aview;
- (void)formatCellTextLabel:(UILabel *)lab;
- (void)formatCellDetailLabel:(UILabel *)lab;
- (NSString*)DataTOjsonString:(id)object;

- (UILabel *)placeLabelInView:(UIView *)view withFrame:(CGRect)rect;
- (UILabel *)placeLabelInView:(UIView *)view withFrame:(CGRect)rect withText:(NSString *)string;
- (UILabel *)placeLabelInView:(UIView *)view withFrame:(CGRect)rect withText:(NSString *)string andTextColor:(UIColor *)color andFont:(UIFont *)font andAlignment:(NSTextAlignment)alignment;
- (UIImageView *)placeImgViewInView:(UIView *)view withFrame:(CGRect)rect withImageStr:(NSString *)imageStr;
- (UIButton *)placeButtonInView:(UIView *)view withFrame:(CGRect)rect withTitle:(NSString *)title orImg:(NSString *)imgname;
//返回去掉空格之后的string;
- (NSString *)stringByClearBlanksplace:(NSString *)targetStr;

/**
 根据moduleUrl获取该模块的权限buttonList，app中检测权限时通常不需要先执行该方法，因为在切换模块时还自己执行，除非判断权限时不一定在当前模块，如切换角色时其他模块的刷新;
 */
-(UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder;
-(UILabel *)createLabelFrame:(CGRect)frame color:(UIColor*)color font:(UIFont *)font text:(NSString *)text;
@end
