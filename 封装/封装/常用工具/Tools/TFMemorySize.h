//
//  TFMemorySize.h
//  封装
//
//  Created by 张永强 on 17/4/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger , TFSizeType) {
    TFSizeBType = 0,
    TFSizeKBType,
    TFSizeMBType,
    TFSizeGBType
};

@interface TFMemorySize : NSObject
#pragma mark -- 内存
/**
 获取设备内存 (包括空闲的内存和使用的内存)
 
 @param type 大小的类型 KB、MB、GB
 @return 内存大小
 */
+ (NSString *)TF_getDeviceMemoryWithType:(TFSizeType)type;

/**
 获取当前任务使用内存
 
 @param type 大小的类型 KB、MB、GB
 @return 内存大小
 */
+ (NSString *)TF_getUserMemoryWithType:(TFSizeType)type;
/**
 获取设备空闲内存
 
 @param type 大小的类型 KB、MB、GB
 @return 内存大小
 */
+ (NSString *)TF_getfreeMemoryWithType:(TFSizeType)type;

#pragma mark -- 磁盘
/**
 获取总磁盘大小
 
 @param type 大小的类型 KB、MB、GB
 @return 磁盘大小
 */
+ (NSString *)TF_getTotalDiskSizeWithType:(TFSizeType)type;

/**
 获取可用磁盘大小
 
 @param type 大小的类型 KB、MB、GB
 @return 磁盘大小
 */
+ (NSString *)TF_getAvailableDiskSizeWithType:(TFSizeType)type;
#pragma mark -- 转换
/**
 转换成需要大小
 
 @param fileSize 转换的大小
 @param type 大小的类型 KB、MB、GB
 @return 大小字符串
 */
+ (NSString *)TF_fileSizeToString:(unsigned long long)fileSize  withType:(TFSizeType)type;



@end
