//
//  Tool.m
//  封装
//
//  Created by 张永强 on 17/3/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "Tool.h"


@implementation Tool
#pragma mark -- 正则表达式判断相关
/**
 手机号码合法判断（所有的号码，排除11111111111）

 @param phoneStr 手机号
 @return 是否合法
 */
+(BOOL)TF_judgePhoneIsLegalWithPhoneStr:(NSString *)phoneStr
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,184
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,177,180,189,181
     */
    
    //手机号以13,14,15,18,17开头，八个 \d 数字字符
    //    NSString *pattern = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-345-9]|7[013678])\\d{8}$";
    BOOL isMatch = NO;
    if (phoneStr.length != 11) {
        return isMatch;
    }
    if ([phoneStr isEqualToString:@"11111111111"]) {
        return isMatch;
    }
    NSString *pattern = @"^[1][0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:phoneStr];
    return isMatch;
}
/**
 判断密码，只由数字和字母组成

 @param pwdStr 判断字符串
 @param from 从多长
 @param to 到多长
 @return   返回密码是否符合格式
 */
+ (BOOL)TF_judgePasswordWithStr:(NSString *)pwdStr from:(int)from to:(int)to {
    
    NSString *regular = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%d,%d}$" , from , to];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [pred evaluateWithObject:pwdStr];
}
/**
 判断名字，只由汉字和字母组成
 
 @param nameStr 判断字符串
 @param length  名字的长度
 @return   返回密码是否符合格式
 */
+ (BOOL)TF_judgeNameWithStr:(NSString *)nameStr length:(int)length {
    
    NSString *regular = [NSString stringWithFormat:@"[a-zA-Z]|[\u4e00-\u9fa5]|[a-zA-Z\u4e00-\u9fa5]+{0,%d}$" , length];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [pred evaluateWithObject:nameStr];
}
+ (BOOL)TF_isValidateEmail:(NSString *)emial {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , emailRegex];
    return [emailPre evaluateWithObject: emial];
}
+ (BOOL)TF_isCorrectFormatWithRegularExpression:(NSString *)regular withStr:(NSString *)str{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , regular];
    return [pred evaluateWithObject:str];
}
+ (BOOL)TF_isValidCar:(NSString *)carStr{
    NSString *regular = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    return [Tool TF_isCorrectFormatWithRegularExpression:regular withStr:carStr];
}


#pragma mark -- 表情符号判断
/**
 判断输入的是否为表情符号
 
 @param string 输入字符串
 @return 是否为表情
 */
+ (BOOL)TF_stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
#pragma mark -- 获取当前控制器
/**
 获取当前控制器
 
 @return 当前控制器
 */
+(UIViewController *)TF_getCurrentController{
    
    UIViewController *reController = nil;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if (window.windowLevel!= UIWindowLevelNormal) {
        NSArray *array = [[UIApplication sharedApplication]windows];
        for (UIWindow *win in array) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    UIView *cuView = [[window subviews]objectAtIndex:0];
    id responder = [cuView nextResponder];
    if ([responder isKindOfClass:[UIViewController class]]) {
        reController = responder;
    }
    else{
        reController = window.rootViewController;
    }
    return reController;
}


@end
