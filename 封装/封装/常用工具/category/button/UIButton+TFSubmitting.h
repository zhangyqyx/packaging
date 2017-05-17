//
//  UIButton+TFSubmitting.h
//  封装
//
//  Created by 张永强 on 17/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIButton (TFSubmitting)

/**
 提交按钮显示一个加载器
 */
- (void)TF_beginSubmitting;

/**
 结束加载器加载
 */
- (void)TF_endSubmitting;

/**
 按钮是否正在提交
 */
@property(nonatomic, readonly, getter=isSubmitting)NSNumber *submitting;

@end
