//
//  TFFileManager.h
//  封装
//
//  Created by 张永强 on 17/5/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFFileManager : NSObject

#pragma mark -- 文件相关操作

/**
 判断当前目录下文件是否存在
 @param path 文件路径
 @return 是否存在
 */
+ (BOOL)TF_isExistAtPath:(NSString *)path;

/**
  判断是否是文件夹
 @param path 文件夹路径
 @return 是否是文件夹
 */
+ (BOOL)TF_isDirectoryAtPath:(NSString *)path;
/**
 判断文件是否可读
 @param path 文件路径
 @return 是否可读
 */
+ (BOOL)TF_isReadAtPath:(NSString *)path;
/**
 判断文件是否可写
 @param path 文件路径
 @return 是否可写
 */
+ (BOOL)TF_isWriteAtPath:(NSString *)path;
/**
 判断文件是否可删除
 @param path 文件路径
 @return 是否可删除
 */
+ (BOOL)TF_isDeleteAtPath:(NSString *)path;

#pragma mark -- 获取文件路径
//app路径
+ (NSString *)TF_getAppPath;
//Documents
+ (NSString *)TF_getDocuments;
//Tmp
+ (NSString *)TF_getTmp;
//LibraryCaches
+ (NSString *)TF_getLibraryCaches;

#pragma mark -- 获取文件目录

/**
 获取文件下所有的文件及文件夹下的子文件

 @param path 文件路径
 @return 所有文件
 */
+ (NSArray *)TF_getAllDirectoryWithFile:(NSString *)path;

/**
 获取文件夹下的文件以及文件夹（不包括子文件）

 @param path 文件路径
 @return 所有文件
 */
+ (NSArray *)TF_getDirectoryWithFile:(NSString *)path;

#pragma mark -- 文件管理

/**
 创建一个文件夹

 @param path 文件夹路径
 @return 是否成功
 */
+ (BOOL)TF_createDirectoryWithPath:(NSString *)path;
/**
 创建一个文件
 @param path 文件路径
 @param fileData 写入文件的内容
 @return 是否成功
 */
+ (BOOL)TF_createFileWithPath:(NSString *)path data:(NSData *)fileData;

/**
 删除一个文件以及文件夹

 @param path 文件路径
 @return 是否成功
 */
+ (BOOL)TF_removeDirectoryAtPath:(NSString *)path;
/**
 移动一个文件或者重命名文件
 @param from 要移动的文件路径
 @param to 移动到的文件路径（不能是已经存在的）
 @return 是否成功
 */
+ (BOOL)TF_moveDirectoryfromPath:(NSString *)from to:(NSString *)to;

/**
 拷贝一个文件或文件
 @param from 要拷贝的文件路径
 @param to 拷贝到哪里的文件路径
 @return 是否成功
 */
+ (BOOL)TF_copyDirectoryOrFilefromPath:(NSString *)from to:(NSString *)to;

/**
 获取创建文件时间
 @param path 文件路径
 @return 时间字符串
 */
+ (NSString *)TF_getDirectoryOrFileCreatDateWithPath:(NSString *)path;

/**
 获取文件修改日期
 @param path 文件路径
 @return 修改时间
 */
+ (NSString *)TF_getDirectoryOrFileChangeDateWithPath:(NSString *)path;
/**
 获取文件大小
 @param path 文件路径
 @return 大小
 */
+ (long )TF_getDirectoryOrFileSizeWithPath:(NSString *)path;

/**
 获取文件所有者
 @param path 文件路径
 @return 文件所有者
 */
+ (NSString *)TF_getDirectoryOrFileOwnerWithPath:(NSString *)path;


@end
