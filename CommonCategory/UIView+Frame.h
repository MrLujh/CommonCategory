//
//  UIView+Frame.h
//  CommonCategory
//
//  Created by lujh on 2018/3/2.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/**
 *  x
 */
@property (nonatomic,assign)  CGFloat x;
/**
 *  y
 */
@property  (nonatomic,assign) CGFloat y;
/**
 *  top
 */
@property (nonatomic, assign) CGFloat top;
/**
 *  bottom
 */
@property (nonatomic, assign) CGFloat bottom;
/**
 *  left
 */
@property (nonatomic, assign) CGFloat left;
/**
 *  right
 */
@property (nonatomic, assign) CGFloat right;
/**
 *  centerX
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  centerY
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  width
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  height
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  size
 */
@property (nonatomic, assign) CGSize size;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

@end
