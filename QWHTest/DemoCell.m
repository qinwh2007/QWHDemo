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
    headerImgv = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeft, kCellTop, 38, 38)];
    headerImgv.contentMode = UIViewContentModeScaleAspectFill;
    headerImgv.clipsToBounds = YES;
    headerImgv.backgroundColor = kWhiteColor;
    [self addSubview:headerImgv];
    
    UIImageView *cornerImage = [[UIImageView alloc] initWithFrame:headerImgv.frame];
    cornerImage.image = [UIImage imageNamed:@"corner_circle_white"];
    [self addSubview:cornerImage];

    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(headerImgv.right + kDistantHor, headerImgv.top , ScreenWidth - kCellLeft*2 , 17)];
    titleLab.textColor = kBlackColor;
    titleLab.numberOfLines = 2;
    [self addSubview:titleLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.left, titleLab.bottom + kDistantHor, 130, 17)];
    timeLab.textColor = kLightGreyColor;
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.font = kFont14;
    [self addSubview:timeLab];
    
    contentLab = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeft, headerImgv.bottom +  kDistantVer, ScreenWidth - kCellLeft*2 , 17)];
    contentLab.numberOfLines = 0;
    contentLab.textColor = kBlackColor;
    [self addSubview:contentLab];
}

- (void)setNotiModel:(QWHNotiModel *)notiModel
{
    _notiModel = notiModel;
//    self.backgroundColor = notiModel.color;
    if (notiModel) {
        CGRect rect = titleLab.frame;

        titleLab.frame = rect;
        
        titleLab.text = notiModel.title;
        contentLab.text = notiModel.content;
        [headerImgv sd_setImageWithURL:[NSURL URLWithString:notiModel.senderPhoto] placeholderImage:kHeaderImg];
        nameLab.text = notiModel.senderName;
        timeLab.text = notiModel.sendtime;
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
