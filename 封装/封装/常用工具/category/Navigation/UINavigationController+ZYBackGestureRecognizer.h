//
//  UINavigationController+ZYBackGestureRecognizer.h
//  封装
//
//  Created by 张永强 on 17/3/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ZYBackGestureRecognizer)
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *zy_popGestureRecognizer;

@end
