//
//  QWHNavigationController.m
//  testNav
//
//  Created by qinwh2008 on 17/2/10.
//  Copyright © 2017年 qinwh2008. All rights reserved.
//

#import "QWHNavigationController.h"
#import "UINavigationItem+CustomBarButtonItem.h"
@interface QWHNavigationController ()<UINavigationControllerDelegate>

@end

@implementation QWHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

//如果现在push的不是栈底控制器,加上返回按钮，若个别页面不需要返回按钮或改变样式，fh；
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        [viewController.navigationItem setLeftItemWithTarget:self action:@selector(back) image:@"back_img"];
        
    }
    // 就有滑动返回功能
    self.interactivePopGestureRecognizer.delegate = nil;
    [super pushViewController:viewController animated:animated];
}

//// 完全展示完调用
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 如果展示的控制器是根控制器，就还原pop手势代理
//    if (viewController == [self.viewControllers firstObject]) {
//        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
//    }
//}

- (void)back {
    UIViewController *vc = self.viewControllers.lastObject;
    if ([vc respondsToSelector:@selector(back)]) {
        [vc performSelectorOnMainThread:@selector(back) withObject:nil waitUntilDone:NO];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --------navigation delegate
//该方法可以解决popRootViewController时tabbar的bug
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
