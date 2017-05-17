//
//  TFSingleton.h
//  封装
//
//  Created by 张永强 on 17/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#ifndef TFSingleton_h
#define TFSingleton_h
#define singleton_interface(class) + (instancetype)shared##class;\
#define singleton_implementation(class)\
static class *_instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\

#endif
