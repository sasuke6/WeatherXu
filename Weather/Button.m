//
//  Button.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/14.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "Button.h"

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//设置button内部的image的范围

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    
    return CGRectMake(0, 5, imageW, imageH);
    
}

//设置button内部的title的范围

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}


@end
