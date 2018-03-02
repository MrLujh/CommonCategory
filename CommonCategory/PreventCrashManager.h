//
//  PreventCrashManager.h
//  PreventArrayBeyondCrash
//
//  Created by lujh on 2017/11/2.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface PreventCrashManager : NSObject
+ (void)sharePreventCrashManager;
+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod;
@end


@interface NSArray (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (id)objectAtIndexOrNil:(NSUInteger)index;
@end


@interface NSMutableArray (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (id)objectAtIndexOrNilM:(NSUInteger)index;
- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
@end


@interface NSMutableDictionary (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end

@interface UIView (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (void)safe_addSubview:(UIView *)view;
@end
