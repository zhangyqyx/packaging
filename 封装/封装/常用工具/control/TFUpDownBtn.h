//
//  TFUpDownBtn.h
//  封装
//
//  Created by 张永强 on 17/4/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFUpDownBtn : UIButton
/**
     图片在上，文字在下的按钮
     
     @param frame 按钮的frame
     @param imgName 图片的名字
     @param title 描述文字
     @return 按钮
 */
+ (TFUpDownBtn *)buttonWithFrame:(CGRect)frame
                       imageName:(NSString *)imgName
                           title:(NSString *)title;

@end
