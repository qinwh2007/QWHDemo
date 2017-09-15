//
//  UINavigationItem+CustomBarButtonItem.h
//  QWHDemo
//
//  Created by qinwh2008 on 2017/9/12.
//  Copyright © 2017年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (CustomBarButtonItem)
- (void)setLeftItemWithTarget:(id)target
                       action:(SEL)action
                        title:(NSString *)title;
- (void)setLeftItemWithTarget:(id)target
                       action:(SEL)action
                        image:(NSString *)image;
- (void)setRightItemWithTarget:(id)target
                        action:(SEL)action
                         title:(NSString *)title;
- (void)setRightItemWithTarget:(id)target
                        action:(SEL)action
                         image:(NSString *)image;
@end
