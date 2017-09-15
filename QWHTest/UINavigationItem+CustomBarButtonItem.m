//
//  UINavigationItem+CustomBarButtonItem.m
//  QWHDemo
//
//  Created by qinwh2008 on 2017/9/12.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "UINavigationItem+CustomBarButtonItem.h"

@implementation UINavigationItem (CustomBarButtonItem)
- (void)setLeftItemWithTarget:(id)target
                       action:(SEL)action
                        title:(NSString *)title
{
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    self.leftBarButtonItem = buttonItem;

}

- (void)setLeftItemWithTarget:(id)target
                       action:(SEL)action
                        image:(NSString *)image
{
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStylePlain target:target action:action];
    self.leftBarButtonItem = buttonItem;

}

- (void)setRightItemWithTarget:(id)target
                        action:(SEL)action
                         title:(NSString *)title
{
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    self.rightBarButtonItem = rightItem;

}

- (void)setRightItemWithTarget:(id)target
                        action:(SEL)action
                         image:(NSString *)image
{
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStylePlain target:target action:action];
    self.rightBarButtonItem = buttonItem;
}

@end
