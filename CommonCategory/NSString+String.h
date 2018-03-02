//
//  NSString+String.h
//  CommonCategory
//
//  Created by lujh on 2018/3/2.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (String)

//正则匹配手机号
-(BOOL)isVAlidPhoneNumber;

//正则匹配邮箱
-(BOOL)isValidEmail;

//正则匹配URL
-(BOOL)isValidUrl;

//是否是银行卡
- (BOOL)IsBankCard;

//根据银行代码获取银行名称
+ (NSString *)getNameOfBank:(NSString *)binNum;

//正则匹配身份证
- (BOOL)isIDCards;

//获取系统版本号
+(NSString *)getMyApplicationVersion;
//获取当前时间
+(NSString*)getCurrentTimeString;
//获取当前日期
+(NSString *)getCurrentDate;
//计算属性文本的宽高
-(CGSize)attrStrSizeWithFont:(UIFont *)font andmaxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing;
//计算文本尺寸
- (CGSize)getSizeWithFont:(CGFloat)fontSize;
//时间戳转时间
-(NSDate *)dateValueWithMillisecondsSince1970;

//检查字符串是否为空
- (BOOL) isBlankString;

//改变某个字体大小颜色
- (NSAttributedString*)attrWtihString:(NSString*)string  fontSize:(UIFont*)font textColor:(UIColor*)color range:(NSUInteger)start rangeLength:(NSUInteger)length;

@end
