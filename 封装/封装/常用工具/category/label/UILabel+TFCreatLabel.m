//
//  UILabel+TFCreatLabel.m
//  封装
//
//  Created by 张永强 on 17/4/24.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UILabel+TFCreatLabel.h"

@implementation UILabel (TFCreatLabel)

+ (instancetype)TF_creatLabelWithText:(NSString *)text {
    return [self TF_creatLabelWithText:text textColor:[UIColor blackColor]];
}

+ (nonnull instancetype)TF_creatLabelWithText:(nullable NSString *)text
                                    textColor:(nonnull UIColor *)textColor {
    return [self TF_creatLabelWithText:text
                             textColor:textColor
                       backgroundColor:[UIColor whiteColor]
                              fontSize:17
                             alignment:NSTextAlignmentLeft];
}

+ (nonnull instancetype)TF_creatLabelWithText:(nullable NSString *)text
                                    textColor:(nonnull UIColor *)textColor
                              backgroundColor:(nonnull UIColor *)bgColor
                                     fontSize:(CGFloat)fontSize
                                    alignment:(NSTextAlignment)alignment {
    UILabel *label          = [[UILabel alloc] init];
    label.text              = text;
    label.textColor         = textColor;
    label.backgroundColor   = bgColor;
    label.font              = [UIFont systemFontOfSize:fontSize];
    label.textAlignment     = alignment;
    label.numberOfLines     = 0;
    return label;
}

@end
