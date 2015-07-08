//
//  BaseNavigationViewController.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/14.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  当tabbr不存在时自动隐藏navigation导航栏
 *
 *  @param viewController viewController description
 *  @param animated       animated description
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //控制器的数量
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
