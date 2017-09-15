//
//  DemoCell.m
//  QWHDemo
//
//  Created by qinwh2008 on 2017/9/12.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeft, 6 , ScreenWidth - kCellLeft*2 , 36)];
    titleLab.textColor = kBlackColor;
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.numberOfLines = 2;
    [self addSubview:titleLab];
    
    flagImgv = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeft, titleLab.frame.origin.y + (titleLab.frame.size.height - 8)/2 , 8, 8)];
    flagImgv.image = [UIImage imageNamed:@"dote_red"];
    flagImgv.hidden = YES;
    [self addSubview:flagImgv];
    
    contentLab = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeft, titleLab.frame.origin.y + titleLab.frame.size.height + kDistantVer, ScreenWidth - kCellLeft*2 , 40)];
    contentLab.numberOfLines = 2;
    contentLab.textColor = kLightGreyColor;
    contentLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:contentLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kDistantVer + contentLab.frame.origin.y + contentLab.frame.size.height, ScreenWidth, 0.5)];
    lineLab.layer.backgroundColor = kWhiteDarkColor.CGColor;
    [self addSubview:lineLab];
    
    headerImgv = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeft, 6 + lineLab.bottom, 38, 38)];
    headerImgv.contentMode = UIViewContentModeScaleAspectFill;
    headerImgv.clipsToBounds = YES;
    [self addSubview:headerImgv];
    
    UIImageView *cornerImage = [[UIImageView alloc] initWithFrame:headerImgv.frame];
    cornerImage.image = [UIImage imageNamed:@"corner_circle_white"];
    cornerImage.highlightedImage = [UIImage imageNamed:@"corner_circle_gray"];
    [self addSubview:cornerImage];
    
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(headerImgv.right + kDistantHor, headerImgv.frame.origin.y + (headerImgv.frame.size.height - 20)/2,200 , 20)];
    nameLab.textColor = kBlackColor;
    nameLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 145, nameLab.frame.origin.y, 130 , 20)];
    timeLab.textColor = kLightGreyColor;
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:timeLab];
    
    cancelDeviceShowBtn = [pub placeButtonInView:self withFrame:CGRectMake(ScreenWidth - 80, 5, 70, 36) withTitle:nil orImg:@"btn_Cancel_display"];
    
    [cancelDeviceShowBtn addTarget:self action:@selector(cancelShowPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNotiModel:(QWHNotiModel *)notiModel
{
    _notiModel = notiModel;
    self.backgroundColor = notiModel.color;
    if (notiModel) {
        CGRect rect = titleLab.frame;
        if (!notiModel.read) {
            rect.origin.x = kCellLeft + flagImgv.frame.size.width + kDistantHor;
        }else{
            rect.origin.x = kCellLeft;
        }
        
        if (!notiModel.deviceShow) {
            rect.size.width = ScreenWidth - rect.origin.x - 15;
            cancelDeviceShowBtn.hidden = YES;
        }else{
            rect.size.width = ScreenWidth - rect.origin.x - 85;
            cancelDeviceShowBtn.hidden = NO;
        }
        titleLab.frame = rect;
        
        flagImgv.hidden = notiModel.read;
        titleLab.text = notiModel.title;
        contentLab.text = notiModel.content;
        [headerImgv sd_setImageWithURL:[NSURL URLWithString:notiModel.senderPhoto] placeholderImage:kHeaderImg];
        nameLab.text = notiModel.senderName;
        timeLab.text = notiModel.sendtime;
    }
}

- (void)cancelShowPressed
{
    [pub showAlertViewWithStr:@"取消后刷卡设备上将不再显示该通知公告！确定取消显示？" cancelBtn:@"取消" sureBtn:@"确定" delegate:self];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([_delegate respondsToSelector:@selector(cancelDeviceShowWithIndex:)]) {
            [_delegate cancelDeviceShowWithIndex:_theIndexpath];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
