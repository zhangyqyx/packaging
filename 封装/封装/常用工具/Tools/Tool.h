//
//  Tool.h
//  封装
//
//  Created by 张永强 on 17/3/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tool : NSObject
#pragma mark -- 正则表达式判断相关
/**
 手机号码合法判断（所有的号码，排除11111111111）
 
 @param phoneStr 手机号
 @return 是否合法
 */
+(BOOL)TF_judgePhoneIsLegalWithPhoneStr:(NSString *)phoneStr;

/**
 判断密码，只由数字和字母组成
 
 @param pwdStr 判断字符串
 @param from 从多长
 @param to 到多长
 @return   返回密码是否符合格式
 */
+ (BOOL)TF_judgePasswordWithStr:(NSString *)pwdStr
                        from:(int)from
                          to:(int)to;
/**
 判断名字，只由汉字和字母组成
 
 @param nameStr 判断字符串
 @param length  名字的长度
 @return   返回密码是否符合格式
 */
+ (BOOL)TF_judgeNameWithStr:(NSString *)nameStr
                  length:(int)length;
/**
 判断邮箱格式

 @param emial 判断的字符串
 @return 是否符合格式
 */
+ (BOOL)TF_isValidateEmail:(NSString *)emial;
/**
 判断是否正确
 
 @param regular 正则表达式字符串
 @param str 要判断的字符串
 @return 是否符合格式
 */
+ (BOOL)TF_isCorrectFormatWithRegularExpression:(NSString *)regular withStr:(NSString *)str;

/**
 判断车牌号码

 @param carStr 车牌号码判断
 @return 是否是车牌号
 */
+ (BOOL)TF_isValidCar:(NSString *)carStr;

#pragma mark -- 获取当前控制器
/**
 获取当前控制器
 @return 当前控制器
 */
+(UIViewController *)TF_getCurrentController;
#pragma mark -- 表情符号判断
/**
 判断输入的是否为表情符号
 
 @param string 输入字符串
 @return 是否为表情
 */
+ (BOOL)TF_stringContainsEmoji:(NSString *)string;




@end
