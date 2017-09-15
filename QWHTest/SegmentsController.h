//
//  SegmentsController.h
//  testNav
//
//  Created by qinwh2008 on 17/2/7.
//  Copyright © 2017年 qinwh2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentsController : UIViewController
@property (strong, nonatomic) NSArray *viewControllers;
@property (assign, nonatomic) BOOL disableUserDrag;  //禁止滑动切换；
@end
