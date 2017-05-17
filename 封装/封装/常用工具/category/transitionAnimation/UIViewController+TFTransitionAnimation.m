//
//  UIViewController+TFTransitionAnimation.m
//  封装
//
//  Created by 张永强 on 17/4/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIViewController+TFTransitionAnimation.h"
#import <objc/message.h>

static NSString *TFPushTranstionKey     = @"TFPushTranstionKey";
static NSString *TFPopTranstionKey      = @"TFPopTranstionKey";
static NSString *TFPresentTranstionKey  = @"TFPresentTranstionKey";
static NSString *TFDismissTranstionKey  = @"TFDismissTranstionKey";
@implementation UIViewController (TFTransitionAnimation)

#pragma mark -- 添加属性
//push/pop
- (void)setTF_pushTranstion:(TFTransitonAnimation *)TF_pushTranstion {
    if (TF_pushTranstion) {
        TF_pushTranstion.transitonType      = TFTransitonAnimationTypeShow;
        self.navigationController.delegate  = self;
        objc_setAssociatedObject(self, &TFPushTranstionKey, TF_pushTranstion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (TFTransitonAnimation *)TF_pushTranstion {
    return objc_getAssociatedObject(self, &TFPushTranstionKey);
}
- (void)setTF_popTransition:(TFTransitonAnimation *)TF_popTransition {
    if (TF_popTransition) {
        TF_popTransition.transitonType      = TFTransitonAnimationTypeHide;
        self.navigationController.delegate  = self;
        objc_setAssociatedObject(self, &TFPopTranstionKey, TF_popTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (TFTransitonAnimation *)TF_popTransition {
    return objc_getAssociatedObject(self, &TFPopTranstionKey);
}
//present/dismiss
- (void)setTF_presentTranstion:(TFTransitonAnimation *)TF_presentTranstion {
    if (TF_presentTranstion) {
        TF_presentTranstion.transitonType   = TFTransitonAnimationTypeShow;
        self.transitioningDelegate          = self;
        objc_setAssociatedObject(self, &TFPresentTranstionKey, TF_presentTranstion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (TFTransitonAnimation *)TF_presentTranstion {
    return objc_getAssociatedObject(self, &TFPresentTranstionKey);
}
- (void)setTF_dismissTransition:(TFTransitonAnimation *)TF_dismissTransition {
    if (TF_dismissTransition) {
        TF_dismissTransition.transitonType   = TFTransitonAnimationTypeHide;
        self.transitioningDelegate          = self;
        objc_setAssociatedObject(self, &TFDismissTranstionKey, TF_dismissTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (TFTransitonAnimation *)TF_dismissTransition {
    return objc_getAssociatedObject(self, &TFDismissTranstionKey);
}
#pragma mark -- push和pop动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush && [fromVC isEqual:self]) {
        return self.TF_pushTranstion;
    }else if (operation == UINavigationControllerOperationPop && [toVC isEqual:self]) {
        return self.TF_popTransition;
    }else {
        return nil;
    }
}
#pragma mark -- present和dismiss动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return (id<UIViewControllerAnimatedTransitioning>)self.TF_presentTranstion;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return (id<UIViewControllerAnimatedTransitioning>)self.TF_dismissTransition;
}

@end
