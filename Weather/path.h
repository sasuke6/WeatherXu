//
//  path.h
//  Weather
//
//  Created by Xusasuke6 on 15/5/28.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface path : UIBezierPath
@property (nonatomic ,strong) UIColor *color;

+(instancetype)piantLineWidth:(CGFloat) width color:(UIColor *)color firstPoint:(CGPoint)begin;

@end
