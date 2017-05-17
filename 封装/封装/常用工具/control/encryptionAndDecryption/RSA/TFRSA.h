//
//  TFRSA.h
//  封装
//
//  Created by 张永强 on 17/5/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFRSA : NSObject

#pragma mark -- 加密
/**
 RSA加密
 @param str 要加密的字符串
 @param pubKey 公钥字符串
 @return 加密后的字符串
 */
+ (NSString *)TF_encryptString:(NSString *)str
                     publicKey:(NSString *)pubKey;
/**
  RSA加密
 @param data 要加密的数据
 @param pubKey 公钥字符串
 @return 加密后的数据
 */
+ (NSData *)TF_encryptData:(NSData *)data
                 publicKey:(NSString *)pubKey;
#pragma mark -- 解密
/**
 RSA解密
 @param str 要解密的字符串
 @param privKey 私钥字符串
 @return 解密后的字符串
 */
+ (NSString *)TF_decryptString:(NSString *)str
                    privateKey:(NSString *)privKey;
/**
 RSA解密
 @param data 要解密的数据
 @param privKey 私钥字符串
 @return 解密后的数据
 */
+ (NSData *)TF_decryptData:(NSData *)data
                privateKey:(NSString *)privKey;

#pragma mark -- 文件密钥加解密
/**
 RSA加密
 @param data 要加密的数据
 @param filePath 公钥路径
 @return 加密后的数据
 */
+ (NSData *)TF_encryptData:(NSData *)data
         publicKeyWithPath:(NSString *)filePath;

/**
 RSA加密
 @param str 要加密的字符串
 @param filePath 公钥路径
 @return 加密后的字符串
 */
+ (NSString *)TF_encryptNSString:(NSString *)str
               publicKeyWithPath:(NSString *)filePath;

/**
 RSA解密
 @param data 要解密的数据
 @param filePath P12 私钥文件路径
 @param password  P12 密码
 @return 解密后的数据
 */
+ (NSData *)TF_decryptData:(NSData *)data
                privateKeyWithPath:(NSString *)filePath
                  password:(NSString *)password;

/**
  RSA解密
 @param str 要解密的字符串
 @param filePath P12 私钥文件路径
 @param password  P12 密码
 @return 解密后的字符串
 */
+ (NSString *)TF_decryptNSString:(NSString *)str
                      privateKeyWithPath:(NSString *)filePath
                        password:(NSString *)password;

@end
