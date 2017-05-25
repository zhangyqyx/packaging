//
//  CoreTextUtils.h
//  CoreText
//
//  Created by 张永强 on 17/5/24.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextImageData.h"
#import "CoreTextData.h"
#import <UIKit/UIKit.h>

@interface CoreTextUtils : NSObject

/**
 *  检测点击位置是否在链接上
 *
 *  @param view  点击区域
 *  @param point 点击坐标
 *  @param data  数据源
 */
+ (CoreTextLinkData *)touchLinkInView:(UIView *)view
                              atPoint:(CGPoint)point
                                 data:(CoreTextData *)data;





@end
