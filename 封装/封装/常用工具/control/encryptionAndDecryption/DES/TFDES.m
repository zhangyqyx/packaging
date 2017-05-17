//
//  TFDES.m
//  封装
//
//  Created by 张永强 on 17/5/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TFDES.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation TFDES
#pragma mark - DES加密
+ (NSString *)TF_encryptWithString:(NSString *)str  key:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    return [[self TF_encryptWithData:[str dataUsingEncoding:NSUTF8StringEncoding] key:keyData] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSData *)TF_encryptWithData:(NSData *)data key:(NSData *)key {
    return [self aesEncryptOrDecrypt:kCCEncrypt data:data dataKey:key mode:kCCOptionECBMode|kCCOptionPKCS7Padding];
}

+ (NSData *)aesEncryptOrDecrypt:(CCOperation)option data:(NSData *)data dataKey:(NSData *)key mode:(int)mode{
    // 设置输出字节
    size_t bufferSize           = [data length] + kCCBlockSizeDES;
    void *buffer                = malloc(bufferSize);
    //加密解密
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(option,
                                          kCCAlgorithmDES,
                                          mode,
                                          [key bytes],
                                          kCCKeySizeDES,
                                          NULL ,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *resultData      = [NSData dataWithBytes:buffer length:encryptedSize];
        free(buffer);
        return resultData;
    } else {
        free(buffer);
        @throw [NSException exceptionWithName:@"加密或者解密"
                                       reason:@"加解密出现问题"
                                     userInfo:nil];
        return resultData;
    }
    return resultData;
}

#pragma mark - DES解密
+ (NSString *)TF_decryptWithString:(NSString *)str key:(NSString *)key {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:[self TF_decryptWithData:data dataKey:[key dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
}
+ (NSData *)TF_decryptWithData:(NSData *)data dataKey:(NSData *)key {
  return [self aesEncryptOrDecrypt:kCCDecrypt data:data dataKey:key mode:kCCOptionECBMode|kCCOptionPKCS7Padding];
}

@end
