//
//  TFFileManager.m
//  封装
//
//  Created by 张永强 on 17/5/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TFFileManager.h"

@implementation TFFileManager
#pragma mark -- 文件操作
+ (BOOL)TF_isExistAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
+ (BOOL)TF_isDirectoryAtPath:(NSString *)path {
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    return isDir;
}
+ (BOOL)TF_isReadAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}
+ (BOOL)TF_isWriteAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}
+ (BOOL)TF_isDeleteAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] isDeletableFileAtPath:path];
}
#pragma mark -- 获取文件路径
//app
+ (NSString *)TF_getAppPath {
    return NSHomeDirectory();
}
//Documents
+ (NSString *)TF_getDocuments {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
//Tmp
+ (NSString *)TF_getTmp {
    return NSTemporaryDirectory();
}
//LibraryCaches
+ (NSString *)TF_getLibraryCaches {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

#pragma mark -- 获取文件目录
+ (NSArray *)TF_getAllDirectoryWithFile:(NSString *)path {
    
    return [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil]];
//    return  [[NSFileManager defaultManager] subpathsAtPath:path];//或者使用这种方法
}
+ (NSArray *)TF_getDirectoryWithFile:(NSString *)path {
    return [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
}
#pragma mark -- 文件管理
+ (BOOL)TF_createDirectoryWithPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}
+ (BOOL)TF_createFileWithPath:(NSString *)path data:(NSData *)fileData {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createFileAtPath:path contents:fileData attributes:nil];
    }
    return NO;
}
+ (BOOL)TF_removeDirectoryAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    return NO;
}
+ (BOOL)TF_moveDirectoryfromPath:(NSString *)from to:(NSString *)to {
    if (![[NSFileManager defaultManager] fileExistsAtPath:to]) {
        return [[NSFileManager defaultManager] moveItemAtPath:from toPath:to error:nil];
    }
    return NO;
}
+ (BOOL)TF_copyDirectoryOrFilefromPath:(NSString *)from to:(NSString *)to {
    return [[NSFileManager defaultManager] copyItemAtPath:from toPath:to error:nil];
}
+ (NSString *)TF_getDirectoryOrFileCreatDateWithPath:(NSString *)path {
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [fileAttribute objectForKey:NSFileCreationDate];
}
+ (NSString *)TF_getDirectoryOrFileChangeDateWithPath:(NSString *)path {
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [fileAttribute objectForKey:NSFileModificationDate];
}
+ (long)TF_getDirectoryOrFileSizeWithPath:(NSString *)path {
    BOOL isDirectory = [self TF_isDirectoryAtPath:path];
    long fileSize = 0;
    if (isDirectory) {
        NSArray *files = [self TF_getAllDirectoryWithFile:path];
        for (NSString *name in files) {
            fileSize += [self TF_getFileSizeWithPath:[NSString stringWithFormat:@"%@/%@" , path , name]];
        }
        return fileSize;
    }else {
        return [self TF_getFileSizeWithPath:path];
    }
}
+ (long)TF_getFileSizeWithPath:(NSString *)path {
    //    unsigned long fileLength = 0;
    //    NSNumber *fileSize;
    //    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    //    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
    //        fileLength = [fileSize unsignedLongLongValue];
    //    }
    //    return fileLength;
    NSFileManager* manager =[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]){
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
}
+ (NSString *)TF_getDirectoryOrFileOwnerWithPath:(NSString *)path {
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [fileAttribute objectForKey:NSFileOwnerAccountName];
}

@end
