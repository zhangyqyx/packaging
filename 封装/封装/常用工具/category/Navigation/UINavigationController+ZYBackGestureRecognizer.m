//
//  UINavigationController+ZYBackGestureRecognizer.m
//  封装
//
//  Created by 张永强 on 17/3/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UINavigationController+ZYBackGestureRecognizer.h"
#import <objc/runtime.h>


@interface ZYFullScreenPopGestureRecognizerDelegate :NSObject<UIGestureRecognizerDelegate>

/**  导航控制器 */
@property (nonatomic , weak)UINavigationController *navigationController;


@end

@implementation ZYFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    CGPoint translation = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    return YES;
}

@end



@implementation UINavigationController (ZYBackGestureRecognizer)

+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(zy_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)zy_pushViewController:(UIViewController *)viewController animated:(BOOL)animated  {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.zy_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.zy_popGestureRecognizer];
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.zy_popGestureRecognizer.delegate = [self zy_fullScreenPopGestureRecognizerDelegate];
        [self.zy_popGestureRecognizer addTarget:internalTarget action:internalAction];
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (![self.viewControllers containsObject:viewController]) {
        [self zy_pushViewController:viewController animated:YES];
    }
    
}
- (ZYFullScreenPopGestureRecognizerDelegate *)zy_fullScreenPopGestureRecognizerDelegate {
    ZYFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[ZYFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}
//获得手势
- (UIPanGestureRecognizer *)zy_popGestureRecognizer {
     UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

@end
