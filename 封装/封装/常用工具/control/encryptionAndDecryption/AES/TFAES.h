//
//  TFAES.h
//  封装
//
//  Created by 张永强 on 17/5/16.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFAES : NSObject

#pragma mark -- AES-CBC加密
/**
  AES-CBC模式加密，默认模式
 @param data 要加密的数据
 @param key 密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @param iv 初始化向量iv为16字节。如果为nil，将抛出异常
 @return 加密后的数据
 */
+ (NSData *)TF_encrptyWithData:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv;
/**
 AES-CBC模式加密，默认模式
 @param str 要加密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @param iv 初始化向量iv为16字节。如果为nil，将抛出异常
 @return 加密后的字符串
 */
+ (NSString *)TF_encrptyWithNSString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;
/**
 AES-CBC模式加密，默认模式
 @param str 要加密的字符串
 @param key Hex形式 密钥支持128 192 256bit，16、24、32字节，转换为16进制字符串长度为32、48、64， 长度错误将抛出异常
 @param iv 初始化向量iv为16字节。如果为nil，将抛出异常
 @return 加密后的字符串
 */
+ (NSString *)TF_encrptyWithNSString:(NSString *)str hexKey:(NSString *)key hexiv:(NSString *)iv;
#pragma mark -- AES-ECB加密
/**
 AES-ECB模式加密，默认模式
 @param str 要加密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @return 加密后的字符串
 */
+ (NSString *)TF_encrptyWithString:(NSString *)str key:(NSString *)key;
/**
 AES-ECB模式加密，默认模式
 @param str 要加密的字符串
 @param key Hex形式，密钥支持128 192 256bit，16、24、32字节，转换为16进制字符串长度为32、48、64，长度错误将抛出异常
 @return 加密后的字符串
 */
+ (NSString *)TF_encrptyWithString:(NSString *)str hexKey:(NSString *)key;
/**
 AES-ECB模式加密，默认模式
 @param str 要加密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @return 加密后的字符串
 */
+ (NSString *)TF_encrptyWithString:(NSString *)str base64Key:(NSString *)key;
/**
 AES-ECB模式加密，默认模式
 @param data 要加密的数据
 @param key  密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @return  加密后的数据
 */
+ (NSData *)TF_encrptyWithData:(NSData *)data dataKey:(NSData *)key;
#pragma mark -- AES-CBC解密
/**
 AES-CBC模式解密
 @param data 要解密的数据
 @param key 密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @param iv 进制字符串形式；初始化向量iv为16字节。如果为nil，则初始化向量为0
 @return 解密后的数据
 */
+ (NSData *)TF_decrptyWithData:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv;
/**
 AES-CBC模式解密
 @param str 要解密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节，转换为16进制字符串长度为32、48、64,长度错误将抛出异常
 @param iv 制字符串形式；初始化向量iv为16字节。如果为nil，则初始化向量为0
 @return 解密后的字符串
 */
+ (NSString *)TF_decrptyWithString:(NSString *)str key:(NSString *)key iv:(NSString *)iv;

/**
 AES-CBC模式解密
 @param str 要解密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节，转换为16进制字符串长度为32、48、64,长度错误将抛出异常
 @param iv 制字符串形式；初始化向量iv为16字节。如果为nil，则初始化向量为0
 @return 解密后的字符串
 */
+ (NSString *)TF_decrptyWithString:(NSString *)str hexkey:(NSString *)key hexIv:(NSString *)iv;
#pragma mark -- AES-ECB解密
/**
  AES-ECB模式解密
 @param data 要解密的数据
 @param key 密钥支持128 192 256bit，16、24、32字节，长度错误将抛出异常
 @return 解密后的数据
 */
+ (NSData *)TF_decrptyWithData:(NSData *)data dataKey:(NSData *)key;

/**
 AES-ECB模式解密
 @param str 要解密的字符串
 @param key Hex形式，密钥支持128 192 256bit，16、24、32字节，转换为16进制字符串长度为32、48、64，长度错误将抛出异常
 @return 解密后的字符串
 */
+ (NSString *)TF_decrptyWithString:(NSString *)str hexkey:(NSString *)key;

/**
 AES-ECB模式解密
 @param str 要解密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节,长度错误将抛出异常
 @return 解密后的字符串
 */
+ (NSString *)TF_decrptyWithString:(NSString *)str key:(NSString *)key;

/**
 AES-ECB模式解密
 @param str 要解密的字符串
 @param key 密钥支持128 192 256bit，16、24、32字节,长度错误将抛出异常
 @return 解密后的字符串
 */
+ (NSString *)TF_decrptyWithString:(NSString *)str base64Key:(NSString *)key;


#pragma mark -- AES256加密解密
/**
 AES 加密
 @param str 要加密的字符串
 @param key 加密的key
 @return 加密后的字符串
 */
+ (NSString *)TF_AES256EncryptWithString:(NSString *)str key:(NSString *)key;
+ (NSString *)TF_AES256DecryptWithString:(NSString *)str key:(NSString *)key;//解密




@end
