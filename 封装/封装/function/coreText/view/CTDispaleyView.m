//
//  CTDispaleyView.m
//  CoreText
//
//  Created by 张永强 on 17/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CTDispaleyView.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"
#import "CoreTextUtils.h"


@interface CTDispaleyView ()<UIGestureRecognizerDelegate>
/** 点击的图片 */
@property (strong,nonatomic)UIImageView *tapImgeView;
/** 遮罩 */
@property (strong,nonatomic)UIView *coverView;
/** 显示链接页 */
@property (strong,nonatomic)UIWebView *webView;

@end


@implementation CTDispaleyView
- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupEvents];
    }
    return self;
}
- (void)setupEvents {
     self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGe  = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(userTapGesture:)];
    tapGe.delegate              = self;
    [self addGestureRecognizer:tapGe];
}


#pragma mark -- 用户点击
- (void)userTapGesture:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    //判断是否点击在图片上
    for (CoreTextImageData *imageData in self.data.imageArray) {
        //翻转坐标系，因为ImageData中的坐标是CoreText的坐标系
        CGRect imageRect = imageData.imagePostion;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        if (CGRectContainsPoint(rect, point)) {
            //点击之后处理逻辑
            [self showTapImage:[UIImage imageNamed:imageData.name]];
            break;
        }
    }
    CoreTextLinkData *linkData = [CoreTextUtils touchLinkInView:self atPoint:point data:self.data];
    
    if (linkData) {
        //点击链接后处理逻辑
        [self showTapLink:linkData.url];
        return;
    }
}
#pragma mark -- 显示图片
-(void)showTapImage:(UIImage *)tapImage {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //图片
    _tapImgeView = [[UIImageView alloc] initWithImage:tapImage];
    _tapImgeView.frame = CGRectMake(0, 0, 300, 200);
    _tapImgeView.center = keyWindow.center;
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)]];
    _coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    _coverView.userInteractionEnabled = YES;
    [keyWindow addSubview:_coverView];
    [keyWindow addSubview:_tapImgeView];
}
//点击蒙版取消
-(void)cancel{
    [_tapImgeView removeFromSuperview];
    [_coverView removeFromSuperview];
}
#pragma mark -- 显示链接网页
-(void)showTapLink:(NSString *)urlStr{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //网页
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    _webView.center = keyWindow.center;
    [_webView setScalesPageToFit:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    _coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    _coverView.userInteractionEnabled = YES;
    
    [keyWindow addSubview:_coverView];
    [keyWindow addSubview:_webView];
}
-(void)hide{
    [_webView removeFromSuperview];
    [_coverView removeFromSuperview];
}



//绘制
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置翻转
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
        for (CoreTextImageData *imageData in self.data.imageArray) {
            UIImage *image = [UIImage imageNamed:imageData.name];
            CGContextDrawImage(context, imageData.imagePostion, image.CGImage);
        }
    }
}
#pragma mark -- delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}

@end
