//
//  ViewController.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/14.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "ViewController.h"
#import "BaseNavigationViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Button.h"
@interface ViewController (){

UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件

Button * _previousBtn;//记录前一次选中的按钮
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tabar的颜色设置和位置设置
    _tabBarView = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor blackColor];
    [self.tabBar addSubview:_tabBarView];
    FirstViewController *first = [[FirstViewController alloc] init];
    SecondViewController *second = [[SecondViewController alloc] init];
    UINavigationController *nav1 = [[BaseNavigationViewController alloc] initWithRootViewController:first]; 
    UINavigationController *nav2 = [[BaseNavigationViewController alloc] initWithRootViewController:second];
    self.viewControllers = [NSArray arrayWithObjects:nav1 , nav2, nil]; // 添加到最顶端的导航栏
    [self creatButtonWithNormalName:@"weather-icon.png" andSelectName:@"weather-icon-highlight.png" andTitle:@"天气" andIndex:0];
    [self creatButtonWithNormalName:@"tuya-icon.png" andSelectName:@"tuya-icon-highlight.png" andTitle:@"涂鸦板" andIndex:1];
    Button * button = _tabBarView.subviews[0];
    [self changeViewController:button];

    
    
}

-(void)creatButtonWithNormalName:(NSString*) normal andSelectName:(NSString *)selected andTitle:(NSString *) title andIndex:(int)index{
    Button * customButton = [Button buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabBarView.bounds.size.width * 0.5;
    CGFloat buttonH = _tabBarView.bounds.size.height;
    
    customButton.frame = CGRectMake(_tabBarView.bounds.size.width  * 0.5 * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:11];
    customButton.titleLabel.textColor = [UIColor grayColor];

    
    [_tabBarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项）
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }
    
}

- (void)changeViewController:(Button *)sender
{
    if(self.selectedIndex != sender.tag){
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        _previousBtn.selected = ! _previousBtn.selected;
        _previousBtn.titleLabel.textColor = [UIColor grayColor];
        _previousBtn = sender;
        _previousBtn.selected = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



//选中选项时移除图像，使其不会重叠
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView* obj in self.tabBar.subviews) {
        if (obj !=_tabBarView) {
            [obj removeFromSuperview];
        }
    }
}
@end
