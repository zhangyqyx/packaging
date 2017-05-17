//
//  TFMemorySize.m
//  封装
//
//  Created by 张永强 on 17/4/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TFMemorySize.h"
//内存导入库
#import <sys/sysctl.h>
#import <mach/mach.h>
//磁盘导入库
#import <sys/mount.h>
#import <sys/param.h>
@implementation TFMemorySize

#pragma mark -- 内存
+ (NSString *)TF_getDeviceMemoryWithType:(TFSizeType)type {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return [NSString stringWithFormat:@"%ld" , NSNotFound];
    }
    return [self TF_fileSizeToString:((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count)) withType:type];
}
+ (NSString *)TF_getfreeMemoryWithType:(TFSizeType)type {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return [NSString stringWithFormat:@"%ld" , NSNotFound];
    }
    return [self TF_fileSizeToString:(vm_page_size *vmStats.free_count) withType:type];
}


+ (NSString *)TF_getUserMemoryWithType:(TFSizeType)type {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return [NSString stringWithFormat:@"%ld" , NSNotFound];
    }
    return [self TF_fileSizeToString:taskInfo.resident_size withType:type];
}

#pragma mark -- 磁盘
+ (NSString *)TF_getTotalDiskSizeWithType:(TFSizeType)type{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return [self TF_fileSizeToString:freeSpace withType:type];
}
+ (NSString *)TF_getAvailableDiskSizeWithType:(TFSizeType)type
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return [self TF_fileSizeToString:freeSpace withType:type];
}
#pragma mark -- 大小转换
+ (NSString *)TF_fileSizeToString:(unsigned long long)fileSize  withType:(TFSizeType)type {
    double KB = 1024.0;
    double MB = KB*KB;
    double GB = MB*KB;
    switch (type) {
        case TFSizeKBType:
            return [NSString stringWithFormat:@"%.2lfKB" ,(double) (fileSize / KB)];
        case TFSizeMBType:
            return [NSString stringWithFormat:@"%.2lfMB" ,(double) (fileSize / MB)];
        case TFSizeGBType:
            return [NSString stringWithFormat:@"%.2lfGB" ,(double) (fileSize / GB)];
        default:
            return [NSString stringWithFormat:@"%lluB" ,fileSize];
    }
}

@end
