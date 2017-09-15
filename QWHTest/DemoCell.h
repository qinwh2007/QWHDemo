//
//  DemoCell.h
//  QWHDemo
//
//  Created by qinwh2008 on 2017/9/12.
//  Copyright © 2017年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QWHNotiModel.h"

@protocol cancelDeviceShowDelegate <NSObject>
- (void)cancelDeviceShowWithIndex:(NSIndexPath *)indexpath;
@end

@interface DemoCell : UITableViewCell
{
    UILabel *titleLab;
    UILabel *contentLab;
    UILabel *nameLab;
    UILabel *timeLab;
    UIImageView *headerImgv;
    UIImageView *flagImgv;
    UIButton *cancelDeviceShowBtn;
}

@property (strong, nonatomic) QWHNotiModel *notiModel;
@property (strong, nonatomic) NSIndexPath *theIndexpath;
@property (assign, nonatomic) id<cancelDeviceShowDelegate>delegate;

@end
