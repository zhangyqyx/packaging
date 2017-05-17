//
//  UIButton+TFCreatBtn.h
//  封装
//
//  Created by 张永强 on 17/4/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TFCreatBtn)
/**
 返回一个按钮
 @param frame 按钮的大小
 @param title 按钮的文字
 @param size 按钮文字的大小
 @param textColor 文字颜色
 @return 按钮
 */
+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame
                                     title:(nullable NSString *)title
                                  fontSize:(CGFloat)size
                                 textColor:(nonnull UIColor *)textColor;
/**
 返回一个按钮
 @param frame 按钮的大小
 @param attributedText 按钮的设置
 @return 按钮
 */
+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame
                            attributedText:(nullable NSAttributedString *)attributedText;

/**
 返回一个按钮
 @param frame 按钮的大小
 @param title 按钮的文字
 @param size 按钮文字的大小
 @param textColor 文字颜色
 @param imageName 图片名字
 @param highlightImage 高亮图片的名字
 @param backImage 按钮背景图片名字
 @return 按钮
 */
+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame
                                     title:(nullable NSString *)title
                                  fontSize:(CGFloat)size
                                 textColor:(nonnull UIColor *)textColor
                                 imageName:(nullable NSString *)imageName
                            highlightImage:(nullable NSString *)highlightImage
                                banckImage:(nullable NSString *)backImage;
/**
 返回一个按钮
 @param frame 按钮的大小
 @param attributedText 按钮的设置
 @param imageName 图片名字
 @param backImage 按钮背景图片名字
 @param highlightImage 高亮图片的名字
 @return 按钮
 */
+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame
                            attributedText:(nullable NSAttributedString *)attributedText
                                 imageName:(nullable NSString *)imageName
                                 backImage:(nullable NSString *)backImage
                            highlightImage:(nullable NSString *)highlightImage;

@end
