//
//  TFUpDownBtn.m
//  封装
//
//  Created by 张永强 on 17/4/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TFUpDownBtn.h"

@interface TFUpDownBtn()
/**图片 */
@property (nonatomic , strong)UIImageView *imgView;
/**文字 */
@property (nonatomic , strong)UILabel *titLabel;

@end

@implementation TFUpDownBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
        _titLabel = [[UILabel alloc] init];
        _titLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置图片的尺寸
    CGRect imageFrame = CGRectMake(20, 0, self.frame.size.width - 40,  self.frame.size.width - 40);
    _imgView.frame = imageFrame;
    //设置label的高度
    CGRect labelFrame = CGRectMake(0, imageFrame.size.height, self.frame.size.width, self.frame.size.height - imageFrame.size.height);
    _titLabel.frame = labelFrame;
}

+ (TFUpDownBtn *)buttonWithFrame:(CGRect)frame imageName:(NSString *)imgName title:(NSString *)title {
    return [[self alloc] buttonWithFrame:frame imageName:imgName title:title];
}
- (TFUpDownBtn *)buttonWithFrame:(CGRect)frame imageName:(NSString *)imgName title:(NSString *)title {
    TFUpDownBtn *btn = [[TFUpDownBtn alloc] initWithFrame:frame];
    btn.imgView.image = [UIImage imageNamed:imgName];
    btn.titLabel.text = title;
    return btn;
}

@end
