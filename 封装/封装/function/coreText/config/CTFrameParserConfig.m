//
//  CTFrameParserConfig.m
//  CoreText
//
//  Created by 张永强 on 17/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _width      = 200.f;
        _fontSize   = 16.0f;
        _lineSpace  = 4.0f;
        _textColor  = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1.0];
    }
    return self;
}



@end
