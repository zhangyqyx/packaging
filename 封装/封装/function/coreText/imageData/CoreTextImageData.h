//
//  CoreTextImageData.h
//  CoreText
//
//  Created by 张永强 on 17/5/24.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoreTextImageData : NSObject

//图片资源名称
@property (copy,nonatomic)NSString *name;
//图片位置的起始点
@property (assign,nonatomic)CGFloat position;
//图片的尺寸
@property (assign,nonatomic)CGRect imagePostion;

@end
