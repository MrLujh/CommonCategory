//
//  UIColor+Color.h
//  CommonCategory
//
//  Created by lujh on 2018/3/2.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)
//使用16进制
+ (instancetype)colorWithHex:(uint32_t)hex;
//随机色
+ (instancetype)randomColor;
@end
