//
//  TFDisplayView.m
//  CoreText
//
//  Created by 张永强 on 17/5/18.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TFDisplayView.h"
#import <CoreText/CoreText.h>

@implementation TFDisplayView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //步骤2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //步骤3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    //步骤4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"您好符号化ahdofadsfdkls时刻表覅赛的萨芬is基本符合等级考试暗示法好多就是上看凤凰军事空间撒放寒假"];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, [attString length]), path, NULL);
    //步骤5
    CTFrameDraw(frame, context);
    //步骤6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetterRef);
}


@end
