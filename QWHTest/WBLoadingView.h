//
//  WBLoadingView.h
//  MyShop
//
//  Created by company on 16/10/10.
//  Copyright © 2016年 W.兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBLoadingView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic,assign) UIEdgeInsets edgeInset;

//便利方法
+ (void)showLoadingInView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)hideLoadingForView:(UIView *)view;

+ (void)hideAllLoadingForView:(UIView *)view;

+ (WBLoadingView *)loadingForView:(UIView *)view;

//实例方法
+ (instancetype)loadViewFromNib;

- (void)showInView:(UIView *)view;

- (void)hide;

@end
