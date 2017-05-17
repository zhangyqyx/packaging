//
//   MacroDefinition.h
//  封装
//
//  Created by 张永强 on 17/4/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#ifndef _MacroDefinition_h
#define _MacroDefinition_h

#pragma mark -- 高度
#define TF_NavigationH     44
#define TF_TopH            64
#define TF_StatusBarH      20
#define TF_TabbarH         65

#define TF_ScreenWidth     ([UIScreen mainScreen].bounds.size.width)
#define TF_ScreenHeight    ([UIScreen mainScreen].bounds.size.height)
#define TF_ScreenSize      ([UIScreen mainScreen].bounds.size)

#pragma mark -- 打印日志
#ifdef DEBUG
   # define TFLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
   # define TFLog(...)
#endif

#pragma mark -- 强弱引用
#define TFWeakSelf(type)    __weak typeof(type) weak##type = type;
#define TFStrongSelf(type)  __strong typeof(type) type     = weak##type;

#pragma mark -- 角度和弧度之间的转换
#define TFDegreesToRadian(x)        (M_PI * (x) / 180.0)
#define TFRadianToDegrees(radian)   (radian*180.0)/(M_PI)
#pragma mark -- 获取图片资源
#define TFGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#pragma mark -- 获取系统版本
#define TF_IOSVersion            [[[UIDevice currentDevice] systemVersion] floatValue]
#define TF_currentSysetmVersion  [[UIDevice currentDevice] systemVersion]
#pragma mark -- 获取当前语言
#define TF_CurrentLanguage   ([[NSLocale preferredLanguages] objectAtIndex:0])
#pragma mark -- 设备判断
//判断是否为iPhone
#define TF_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
//判断是否为iPad
#define TF_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])
//判断是否为ipod
#define TF_IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// 判断是否为 iPhone 5SE
#define TF_iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define TF_iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define TF_iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
#pragma mark -- 判断是真机还是模拟器
//真机模拟器返回
#define TF_ISIPHONEORSIMULATOR TARGET_OS_IPHONE?TARGET_OS_IPHONE:TARGET_IPHONE_SIMULATOR

#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

#pragma mark -- 为空的判断
//字符串是否为空
#define TF_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define TF_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define TF_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define TF_ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark --  获取路径
//获取沙盒Document路径
#define TF_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define TF_TempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define TF_CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


#endif
