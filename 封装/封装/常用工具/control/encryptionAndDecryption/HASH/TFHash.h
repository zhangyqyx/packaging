//
//  TFHash.h
//  封装
//
//  Created by 张永强 on 17/5/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFHash : NSObject
#pragma mark -- md5加密
/**
 最基本的MD5加密  终端命令：md5 -s "123"
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)TF_md5WithSttring:(NSString *)str;

/**
 MD5加盐加密
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)TF_md5SaltingWithSttring:(NSString *)str;

#pragma mark -- SHA
/**
 sha加密
 @param str 要加密的字符串
 @return 加密后的字符串
 */
//终端命令：echo -n "123" | openssl sha -sha1
+ (NSString *)TF_sha1WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha224
+ (NSString *)TF_sha224WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha256
+ (NSString *)TF_sha256WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha384
+ (NSString *)TF_sha384WithString:(NSString *)str;
//终端命令：echo -n "123" | openssl sha -sha256
+ (NSString *)TF_sha512WithString:(NSString *)str;

#pragma mark - HMAC
/**
 HMACmd5加密
 @param str 要加密的字符串
 @param key 用到的key
 @return 加密后的字符串
 */
//终端命令：echo -n "123" | openssl dgst -md5 -hmac "123"
+ (NSString *)TF_hmacMD5WithString:(NSString *)str
                               Key:(NSString *)key;
/**
  HMACsha加密
 @param str 要加密的字符串
 @param key 用到的key
 @return 加密后的字符串
 */
//终端命令：echo -n "123" | openssl sha -sha1 -hmac "123"
+ (NSString *)TF_hmacSHA1WithString:(NSString *)str
                                key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha224 -hmac "123"
+ (NSString *)TF_hmacSHA224WithString:(NSString *)str
                                  key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha256 -hmac "123"
+ (NSString *)TF_hmacSHA256WithString:(NSString *)str
                                  key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha384 -hmac "123"
+ (NSString *)TF_hmacSHA384WithString:(NSString *)str
                                  key:(NSString *)key;
//终端命令：echo -n "123" | openssl sha -sha512 -hmac "123"
+ (NSString *)TF_hmacSHA512WithString:(NSString *)str
                                  key:(NSString *)key;



@end
