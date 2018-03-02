//
//  UIView+Frame.m
//  CommonCategory
//
//  Created by lujh on 2018/3/2.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
/**
 *  x
 */
-(CGFloat)x{
    CGRect frame=[self frame];
    return frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect frame=[self frame];
    frame.origin.x=x;
    [self setFrame:frame];
}
/**
 *  y
 */
-(CGFloat)y{
    CGRect frame=[self frame];
    return frame.origin.y;
}
-(void)setY:(CGFloat)y{
    CGRect frame=[self frame];
    frame.origin.y=y;
    return [self setFrame:frame];
}
/**
 *  top
 */
- (CGFloat)top;
{
    return CGRectGetMinY([self frame]);
}
- (void)setTop:(CGFloat)newtop;
{
    CGRect frame = [self frame];
    frame.origin.y = newtop;
    [self setFrame:frame];
}
/**
 *  bottom
 */
- (CGFloat)bottom;
{
    return CGRectGetMaxY([self frame]);
}
- (void)setBottom:(CGFloat)newbottom;
{
    CGRect frame = [self frame];
    frame.origin.y = newbottom - frame.size.height;
    [self setFrame:frame];
}
/**
 *  left
 */
- (CGFloat)left;
{
    return CGRectGetMinX([self frame]);
}
- (void)setLeft:(CGFloat)newleft;
{
    CGRect frame = [self frame];
    frame.origin.x = newleft;
    [self setFrame:frame];
}
/**
 *  right
 */
- (CGFloat)right;
{
    return CGRectGetMaxX([self frame]);
}
- (void)setRight:(CGFloat)newright;
{
    CGRect frame = [self frame];
    frame.origin.x = newright - frame.size.width;
    
    [self setFrame:frame];
}
/**
 *  centerX
 */
- (CGFloat)centerX;
{
    return [self center].x;
}
- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}
/**
 *  centerY
 */
- (CGFloat)centerY;
{
    return [self center].y;
}
- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}
/**
 *  width
 */
- (CGFloat)width;
{
    return CGRectGetWidth([self frame]);
}
- (void)setWidth:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    [self setFrame:CGRectStandardize(frame)];
}
/**
 *  height
 */
- (CGFloat)height;
{
    return CGRectGetHeight([self frame]);
}
- (void)setHeight:(CGFloat)height;
{
    CGRect frame=[self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}
/**
 *  size
 */
- (CGSize)size;
{
    return [self frame].size;
}
- (void)setSize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}
/**
 *  水平居中
 */
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}
/**
 *  垂直居中
 */
- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}
@end
