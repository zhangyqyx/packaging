//
//  UIButton+TFCreatBtn.m
//  封装
//
//  Created by 张永强 on 17/4/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIButton+TFCreatBtn.h"

@implementation UIButton (TFCreatBtn)

+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame
                                     title:(nullable NSString *)title
                                  fontSize:(CGFloat)size
                                 textColor:(nonnull UIColor *)textColor{
  return [self TF_buttonWithFrame:frame title:title fontSize:size textColor:textColor imageName:nil highlightImage:nil banckImage:nil];
}

+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame attributedText:(nullable NSAttributedString *)attributedText{
    return [self TF_buttonWithFrame:frame attributedText:attributedText imageName:nil backImage:nil highlightImage:nil];
}
+(instancetype)TF_buttonWithFrame:(CGRect)frame
                            title:(NSString *)title
                         fontSize:(CGFloat)size
                        textColor:(UIColor *)textColor
                        imageName:(NSString *)imageName
                   highlightImage:(NSString *)highlightImage
                       banckImage:(NSString *)backImage {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size] ,NSForegroundColorAttributeName:textColor}];
    return [self TF_buttonWithFrame:frame  attributedText:attributedText imageName:imageName backImage:backImage highlightImage:highlightImage];
}


+ (nonnull instancetype)TF_buttonWithFrame:(CGRect)frame
                            attributedText:(NSAttributedString *)attributedText
                                 imageName:(NSString *)imageName
                                 backImage:(NSString *)backImage
                            highlightImage:(NSString *)highlightImage {
    UIButton *button = [[self alloc] init];
    button.frame = frame;
    [button setAttributedTitle:attributedText forState:UIControlStateNormal];
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    }
    if (backImage != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    
    return button;
}


@end
