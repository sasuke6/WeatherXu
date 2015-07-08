//
//  piantView.m
//  Weather
//
//  Created by Xusasuke6 on 15/5/25.
//  Copyright (c) 2015年 Xusasuke6. All rights reserved.
//

#import "piantView.h"
#import "path.h"

@interface piantView()
@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) NSMutableArray *paths;

@end


@implementation piantView



- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    
    return _paths;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    if (_width == 0) {
        _width = 2;
    }
    // 创建路径
    path *p = [path piantLineWidth:self.width color:self.color firstPoint:pos];

    self.path = p;
    [self.paths addObject:p];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 确定终点
    [_path addLineToPoint:pos];
    
    // 重绘
    [self setNeedsDisplay];
    
}



- (void)drawRect:(CGRect)rect
{
    if (!self.paths.count) {
        return;
    }
    
    // 遍历所有的路径绘制
    for (path *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
        [path.color set];
        [path stroke];
        }
        
    }
    
}

-(void)clearAction
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)cancelAction
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}


-(void)setImage:(UIImage *)image
{
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

@end
