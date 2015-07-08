//
//  path.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/28.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "path.h"

@implementation path

+(instancetype)piantLineWidth:(CGFloat)width color:(UIColor *)color firstPoint:(CGPoint)begin
{
    path *path = [[self alloc] init];
    path.lineWidth = width;
    path.color = color;
    [path moveToPoint:begin];
    return path;

}

@end
