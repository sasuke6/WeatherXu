//
//  piantView.h
//  Weather
//
//  Created by Xusasuke6 on 15/5/25.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"


@class piantView;
@interface piantView : UIView

@property (nonatomic, assign) CGFloat width;
@property (nonatomic ,strong) UIColor *color;
@property (nonatomic ,strong) UIImage *image;

-(void)clearAction;

-(void)cancelAction;

@end
