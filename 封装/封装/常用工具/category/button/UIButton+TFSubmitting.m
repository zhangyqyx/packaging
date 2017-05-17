//
//  UIButton+TFSubmitting.m
//  封装
//
//  Created by 张永强 on 17/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIButton+TFSubmitting.h"
#import <objc/message.h>

@interface UIButton ()
@property(nonatomic, strong) UIActivityIndicatorView *spinnerView;
@end


@implementation UIButton (TFSubmitting)
- (void)TF_beginSubmitting{
    [self TF_endSubmitting];
    self.submitting                         = @YES;
    self.hidden                             = YES;

    self.spinnerView                        = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGFloat minSize = MIN(self.frame.size.width, self.frame.size.height);
    self.spinnerView.frame                  = CGRectMake(self.frame.origin.x, self.frame.origin.y, minSize, minSize);
    self.spinnerView.backgroundColor        = [self.backgroundColor colorWithAlphaComponent:0.6];
    self.spinnerView.layer.cornerRadius     = self.layer.cornerRadius;
    self.spinnerView.layer.borderWidth      = self.layer.borderWidth;
    self.spinnerView.layer.borderColor      = self.layer.borderColor;
    [self.superview addSubview:self.spinnerView];
    [self.spinnerView startAnimating];
}
- (void)TF_endSubmitting {
    if (!self.isSubmitting.boolValue) {
        return;
    }
    
    self.submitting         = @NO;
    self.hidden             = NO;
    
    [self.spinnerView removeFromSuperview];
    self.spinnerView        = nil;
}
- (NSNumber *)isSubmitting {
    return objc_getAssociatedObject(self, @selector(setSubmitting:));
}

- (void)setSubmitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setSubmitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)spinnerView {
    return objc_getAssociatedObject(self, @selector(setSpinnerView:));
}

- (void)setSpinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setSpinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
