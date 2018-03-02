//
//  NSString+String.m
//  CommonCategory
//
//  Created by lujh on 2018/3/2.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "NSString+String.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (String)

//正则匹配手机号
-(BOOL)isVAlidPhoneNumber
{
    NSString *regex = @"^1\\d{10}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch =[pred evaluateWithObject:self];
    return isMatch;
    
    //    return self.length==11 ? YES : NO;
}
//正则匹配邮箱
-(BOOL)isValidEmail
{
    //    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *regex = @"[\\.A-Za-z0-9\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}
//正则匹配URL
-(BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
//是否是银行卡
- (BOOL)IsBankCard
{
    if(self.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < self.length; i++)
    {
        c = [self characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
//正则匹配身份证
- (BOOL)isIDCards{
    NSString *cardNO = [self stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
    if (cardNO.length == 18){
        // 正则表达式判断基本 身份证号是否满足格式
        NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
        NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        //如果通过该验证，说明身份证格式正确，但准确性还需计算
        if(![identityStringPredicate evaluateWithObject:cardNO]) return NO;
        //** 开始进行校验 *//
        //将前17位加权因子保存在数组里
        NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++) {
            NSInteger subStrIndex  = [[cardNO substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum      += subStrIndex * idCardWiIndex;
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString *idCardLast= [cardNO substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2) {
            if(![idCardLast isEqualToString:@"X"]&&![idCardLast isEqualToString:@"x"]) {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return NO;
            }
        }
        return YES;}
    else if (cardNO.length == 15){
        
        
        NSMutableString *mString = [NSMutableString stringWithString:cardNO];
        [mString insertString:@"19" atIndex:6];
        
        [mString appendString:@"0"];
        NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
        NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        if([identityStringPredicate evaluateWithObject:cardNO]){
            return YES;
        }else{
            return NO;
        }
    }else{
        
        return NO;
    }
}
//获取系统版本号
+(NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *shortVersion = [info objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", shortVersion];
    
    // NSString *bundleVersion = [info objectForKey:@"CFBundleVersion"];  测试字段号
    // NSString *name = [info  objectForKey:@"CFBundleDisplayName"];  app 名字
}
//获取当前时间
+(NSString*)getCurrentTimeString
{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    return currentDateString;
}

//获取当前日期
+ (NSString *)getCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//计算文本尺寸
- (CGSize)getSizeWithFont:(CGFloat)fontSize{
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
    CGSize strSize = [self boundingRectWithSize:size
                                        options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{ NSFontAttributeName:font}
                                        context:nil].size;
    return strSize;
}

//计算属性文本的宽高
/**
 *  计算属性字符文本占用的宽高
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *  @param lineSpacing 行间距
 *  @return 占用的宽高
 */
-(CGSize)attrStrSizeWithFont:(UIFont *)font andmaxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSDictionary *dict = @{NSFontAttributeName: font,
                           NSParagraphStyleAttributeName: paragraphStyle};
    CGSize sizeToFit = [self boundingRectWithSize:maxSize
                                          options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:dict
                                          context:nil].size;
    return sizeToFit;
}
//时间戳转时间
-(NSDate *)dateValueWithMillisecondsSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
}
//检查字符串是否为空
- (BOOL)isBlankString{
    
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


//改变某个字体大小颜色
- (NSAttributedString*)attrWtihString:(NSString*)string  fontSize:(UIFont*)font textColor:(UIColor*)color range:(NSUInteger)start rangeLength:(NSUInteger)length
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(start, length)];
    UIFont *boldFont = font;
    [attributedString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(start, length)];
    return  attributedString;
}

@end
