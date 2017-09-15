//
//  ViewController.m
//  QWHTest
//
//  Created by qinwh2008 on 2017/9/13.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIImageView *myImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _myImageView.image = [UIImage imageNamed:@"IMG_1927.JPG"];
    [self.view addSubview:_myImageView];
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //  毛玻璃视图
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    //添加到要有毛玻璃特效的控件中
    effectView.frame= _myImageView.bounds;
    [_myImageView addSubview:effectView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 84 , ScreenWidth - 30, ScreenHeight - 64 - 49)];
    textView.font = Font(16);
    textView.textColor = kRedColor;
    textView.text = @"又一季盛夏的巡礼,在这单薄的日子里,\n\n拾捡着落叶无意的流离,用孩子的笔体写满了小心翼翼,\n\n封夹在沉浸着五味心情的书页里，剧情像某部无关爱情的电影，\n\n附上了青涩单纯的学生情结,那些风中摇摆的马尾辫,\n\n还有流淌在时光里的薄荷味道的笑。青春是一段没有方向的漂泊，\n\n却一直听着花开，直到花落。";
    textView.backgroundColor = [UIColor clearColor];
    
    textView.layer.shadowOpacity = 1;
    textView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    textView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    textView.layer.shadowRadius = 0.1;

    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
