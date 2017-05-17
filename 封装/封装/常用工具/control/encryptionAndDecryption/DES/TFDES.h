//
//  TFDES.h
//  封装
//
//  Created by 张永强 on 17/5/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFDES : NSObject

#pragma mark - DES加密
/**
 DES加密
 @param str 要加密的字符串
 @param key 加密的key
 @return 加密后的字符串
 */
+ (NSString *)TF_encryptWithString:(NSString *)str  key:(NSString *)key;
/**
  DES加密
 @param data 要加密的数据
 @param key 加密的key
 @return 加密后的数据
 */
+ (NSData *)TF_encryptWithData:(NSData *)data key:(NSData *)key;

#pragma mark - DES解密
/**
 DES解密
 @param str 要解密的字符串
 @param key 解密的key
 @return 解密后的字符串
 */
+ (NSString *)TF_decryptWithString:(NSString *)str key:(NSString *)key;
/**
 DES解密
 @param data 要解密的数据
 @param key 解密的key
 @return 解密后的数据
 */
+ (NSData *)TF_decryptWithData:(NSData *)data dataKey:(NSData *)key;



@end
