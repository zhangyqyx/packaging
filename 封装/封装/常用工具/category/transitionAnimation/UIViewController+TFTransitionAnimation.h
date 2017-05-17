//
//  UIViewController+TFTransitionAnimation.h
//  封装
//
//  Created by 张永强 on 17/4/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTransitonAnimation.h"

@interface UIViewController (TFTransitionAnimation)<UINavigationControllerDelegate , UIViewControllerTransitioningDelegate>

/** push操作 */
@property (nonatomic , strong)TFTransitonAnimation *TF_pushTranstion;
/** pop操作 */
@property (nonatomic , strong)TFTransitonAnimation *TF_popTransition;

/** present操作 */
@property (nonatomic , strong)TFTransitonAnimation *TF_presentTranstion;
/** dismiss操作 */
@property (nonatomic , strong)TFTransitonAnimation *TF_dismissTransition;

@end
