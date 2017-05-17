//
//  TFArbitrarilyButton.m
//  封装
//
//  Created by 张永强 on 17/4/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TFArbitrarilyButton.h"
#import "UIImage+TFFunction.h"

#define kAlphaVisibleThreshold (0.1f)

@interface TFArbitrarilyButton ()

/**点击的点 */
@property (nonatomic , assign)CGPoint previousTouchPoint;
/**点击的位置是否响应 */
@property (nonatomic , assign)BOOL previousTouchHintTestResponse;
/**按钮图片 */
@property (nonatomic , strong)UIImage *buttonImage;
/** 按钮背景图片 */
@property (nonatomic, strong) UIImage *buttonBackground;

@end

@implementation TFArbitrarilyButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}
- (void)setup {
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}
- (void)updateImageCacheForCurrentState {
    _buttonBackground = [self currentBackgroundImage];
    _buttonImage = [self currentImage];
}
- (void)resetHitTestCache {
    self.previousTouchPoint = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    self.previousTouchHintTestResponse = NO;
}

#pragma mark -- 判断图片在此区域是否不透明
- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image {
    CGSize iSize                = image.size;
    CGSize bSize                = self.bounds.size;
    point.x                     *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y                     *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    UIColor *pixelColor         = [image TF_colorAtPoint:point];
    CGFloat alpha               = 0.0;
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    }else {
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha                   = CGColorGetAlpha(cgPixelColor);
    }
    return alpha                >= kAlphaVisibleThreshold;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {
        return superResult;
    }
    if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
        return self.previousTouchHintTestResponse;
    }else {
        self.previousTouchPoint     = point;
    }
    BOOL response  = NO;
    if (self.buttonImage == nil && self.buttonBackground == nil) {
        response   = YES;
    }else if (self.buttonImage == nil && self.buttonBackground != nil){
        response   = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
    }else if (self.buttonImage != nil && self.buttonBackground == nil ){
        response   = [self isAlphaVisibleAtPoint:point forImage:self.buttonImage];
    }else {
        if ([self isAlphaVisibleAtPoint:point forImage:self.buttonImage]) {
            response = YES;
        } else {
            response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
        }
    }
    self.previousTouchHintTestResponse = response;
    return response;
}
#pragma mark -- set方法
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self setup];
}
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [super setBackgroundImage:image forState:state];
    [self setup];
}
- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateImageCacheForCurrentState];
}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateImageCacheForCurrentState];
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateImageCacheForCurrentState];
}


@end
