//
//  HandleView.h
//  Weather
//
//  Created by Xusasuke6 on 15/5/28.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HandleViewBlock)(UIImage *image);


@interface HandleView : UIView
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) HandleViewBlock block;
@end
