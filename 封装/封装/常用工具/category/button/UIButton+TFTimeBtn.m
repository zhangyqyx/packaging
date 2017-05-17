//
//  UIButton+TFTimeBtn.m
//  封装
//
//  Created by 张永强 on 17/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIButton+TFTimeBtn.h"

/** 倒计时的显示时间 */
static NSInteger secondsCountDown;
/** 记录总共的时间 */
static NSInteger allTime;
/** 定时器 */
static NSTimer *timer;
@implementation UIButton (TFTimeBtn)
- (void)TF_buttonWithTime:(CGFloat)countDownTime {
    self.userInteractionEnabled = NO;
    secondsCountDown = 60 * countDownTime;
    allTime = 60 * countDownTime;
    [self setTitle:[NSString stringWithFormat:@"%lds后重新获取",secondsCountDown] forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
}
-(void)timeFireMethod:(NSTimer *)countDownTimer{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    [self setTitle:[NSString stringWithFormat:@"%lds后重新获取",secondsCountDown] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown == 0){
        [countDownTimer invalidate];
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        secondsCountDown = allTime;
        self.userInteractionEnabled = YES;
    }
}
- (void)dealloc {
    [timer invalidate];
    timer = nil;
}
+ (void)TF_invalidateTime {
    [timer invalidate];
    timer = nil;
}


@end
