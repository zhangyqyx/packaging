//
//  UIButton+TFTimeBtn.h
//  封装
//
//  Created by 张永强 on 17/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TFTimeBtn)
/**
 按钮倒计时的问题
 @param countDownTime 倒计时的时间(分钟)
 */
- (void)TF_buttonWithTime:(CGFloat)countDownTime;

/**
 释放定时器
 */
+ (void)TF_invalidateTime;

@end
