//
//  CTFrameParserConfig.h
//  CoreText
//
//  Created by 张永强 on 17/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//用于配置绘制的参数，如文字颜色、大小、行间距等
@interface CTFrameParserConfig : NSObject
/**宽度 */
@property (nonatomic , assign)CGFloat width;
/**字体大小 */
@property (nonatomic , assign)CGFloat fontSize;
/** 行间隔 */
@property (nonatomic , assign)CGFloat lineSpace;
/** 文本颜色 */
@property (nonatomic , strong)UIColor *textColor;


@end
