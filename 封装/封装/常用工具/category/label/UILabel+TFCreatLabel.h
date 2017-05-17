//
//  UILabel+TFCreatLabel.h
//  封装
//
//  Created by 张永强 on 17/4/24.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TFCreatLabel)

/**
 快速创建label
 @param text 字体
 @param textColor 字体颜色
 @param bgColor 背景颜色
 @param fontSize 字体大小
 @param alignment 居中方式
 @return label
 */
+ (nonnull instancetype)TF_creatLabelWithText:(nullable NSString *)text
                                    textColor:(nonnull UIColor *)textColor
                              backgroundColor:(nonnull UIColor *)bgColor
                                     fontSize:(CGFloat)fontSize
                                    alignment:(NSTextAlignment)alignment;
/**
 快速创建label
 @param text 字体
 @param textColor 字体颜色
 @return label;
 */
+ (nonnull instancetype)TF_creatLabelWithText:(nullable NSString *)text
                                    textColor:(nonnull UIColor *)textColor;


/**
 快速创建label
 @param text 字体
 @return label
 */
+ (nonnull instancetype)TF_creatLabelWithText:(nullable NSString *)text;



@end
