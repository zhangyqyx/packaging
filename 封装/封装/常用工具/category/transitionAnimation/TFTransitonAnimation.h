//
//  TFTransitonAnimation.h
//  封装
//
//  Created by 张永强 on 17/4/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , TFTransitonAnimationType) {
    TFTransitonAnimationTypeShow = 0,
    TFTransitonAnimationTypeHide,
};

@interface TFTransitonAnimation : NSObject<UIViewControllerAnimatedTransitioning>

/** 转场方式 显示-隐藏 */
@property (nonatomic , assign)TFTransitonAnimationType transitonType;

- (nonnull instancetype)initWithAnchorRect:(CGRect)anchorRect;
+ (nonnull instancetype)transitionWithRect:(CGRect)anchorRect;


@end
