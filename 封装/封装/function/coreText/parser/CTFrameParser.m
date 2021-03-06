//
//  CTFrameParser.m
//  CoreText
//
//  Created by 张永强 on 17/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CTFrameParser.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"

@implementation CTFrameParser

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config {
    CGFloat fontSize                            = config.fontSize;
    CTFontRef fontRef                           = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing                         = config.lineSpace;
    const CFIndex kNumberOfSettings             = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings]
                                                = {
                                            {kCTParagraphStyleSpecifierAlignment,sizeof(CGFloat),&lineSpacing},
                                            {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpacing},
                                            {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpacing}
                                                };
    CTParagraphStyleRef theParagraphRef         = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor *textColor                          = config.textColor;
    
    NSMutableDictionary *dict                   = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName]   = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName]              = (__bridge id _Nullable)(fontRef);
    dict[(id)kCTParagraphStyleAttributeName]    = (__bridge id)theParagraphRef;
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config {
    NSDictionary *attributes            = [self attributesWithConfig:config];
    NSAttributedString *contentString   = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    return [CTFrameParser parseAttributedContent:contentString config:config];
}
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content
                                  config:(CTFrameParserConfig *)config {
    //创建CTFramesettterRef实例
    CTFramesetterRef framesetter        = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    //获得要绘制的区域高度
    CGSize restrictSize                 = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize                 = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeigt                   = coreTextSize.height;
    //生成CTFrameRef实例
    CTFrameRef frame                    = [self createFrameWithFrameSetter:framesetter
                                                                    config:config
                                                                     heigt:textHeigt];
    //将生成好的CTFrameRef实例和计算好的绘制高度保存到CoreTextData实例中，最后返回
    CoreTextData *data                  = [[CoreTextData alloc] init];
    data.ctFrame                        = frame;
    data.height                         = textHeigt;
    //释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}
+ (CTFrameRef )createFrameWithFrameSetter:(CTFramesetterRef)framesetterRef
                                   config:(CTFrameParserConfig *)config
                                    heigt:(CGFloat)height {
    CGMutablePathRef path   = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frame        = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config {
    NSMutableArray *imageArray  = [NSMutableArray array];
    NSMutableArray *linkArray   = [NSMutableArray array];
    NSAttributedString *content = [self loadTemplateFile:path
                                                  config:config
                                              imageArray:imageArray
                                               linkArray:linkArray];
    CoreTextData *data          = [self parseAttributedContent:content
                                                        config:config];
    data.imageArray             = imageArray;
    data.linkArray              = linkArray;
    return data;
}
//读取JSON文件内容，并且调用方法三获得从NSDcitionay到NSAttributedString的转换结果
+ (NSAttributedString *)loadTemplateFile:(NSString *)path
                                  config:(CTFrameParserConfig *)config
                              imageArray:(NSMutableArray *)imageArray
                               linkArray:(NSMutableArray *)linkArray{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result       = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *array                      = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:NSJSONReadingAllowFragments
                                                                                error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in array) {
                NSString *type              = dic[@"type"];
                if ([type isEqualToString:@"txt"]) { //文本
                    NSAttributedString *as  = [self parseAttributedContentFromDictionary:dic
                                                                                  config:config];
                    [result appendAttributedString:as];
                }else if ([type isEqualToString:@"img"]) {//图片
                    CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
                    imageData.name          = dic[@"name"];
                    imageData.position      = [result length];
                    [imageArray addObject:imageData];
                    NSAttributedString *as  = [self parseImageDataFromDictionary:dic
                                                                          config:config];
                    [result appendAttributedString:as];
                }else if ([type isEqualToString:@"link"]) {//链接
                    NSUInteger startPos     = result.length;
                    NSAttributedString *as  = [self parseAttributedContentFromDictionary:dic config:config];
                    [result appendAttributedString:as];
                    //创建CoreTextLinkData
                    NSUInteger length       = result.length - startPos;
                    NSRange linkRange       = NSMakeRange(startPos, length);
                    CoreTextLinkData *linkData = [[CoreTextLinkData alloc] init];
                    linkData.title          = dic[@"content"];
                    linkData.url            = dic[@"url"];
                    linkData.range          = linkRange;
                    [linkArray addObject:linkData];
                }
            }
        }
    }
    return result;
}
//将NSDcitionay内容转换为NSAttributedString
+ (NSAttributedString *)parseAttributedContentFromDictionary:(NSDictionary *)dict
                                                      config:(CTFrameParserConfig *)config {
    NSMutableDictionary *attributes                     = [NSMutableDictionary dictionaryWithDictionary:[self attributesWithConfig:config]];
    
    //设置颜色
    UIColor *color                                      = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    
    //设置字号
    CGFloat fontSize                                    = [dict[@"size"] floatValue];
    if (fontSize>0) {
        CTFontRef fontRef                               = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName]            = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    
    NSString *content                                   = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}
// 提供将NSString转换为UIColor的功能
+(UIColor *)colorFromTemplate:(NSString *)name{
    
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if ([name isEqualToString:@"red"]){
        return [UIColor redColor];
    }else if ([name isEqualToString:@"black"]){
        return [UIColor blackColor];
    }else if([ name isEqualToString:@"purple"]){
        return [UIColor purpleColor];
    }else {
        return nil;
    }
}
#pragma mark - 添加设置CTRunDelegate信息的方法
static CGFloat ascentCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback(void *ref){
    
    return 0;
}
static CGFloat widthCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}
+ (NSAttributedString *)parseImageDataFromDictionary:(NSDictionary *)dict
                                              config:(CTFrameParserConfig *)config {
    CTRunDelegateCallbacks callbacks;
    //当初始化一个字节单位的数组时，可以用memset把每个数组单元初始化成0
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version                   = kCTRunDelegateVersion1;
    callbacks.getAscent                 = ascentCallback;
    callbacks.getDescent                = descentCallback;
    callbacks.getWidth                  = widthCallback;
    CTRunDelegateRef delegate           = CTRunDelegateCreate(&callbacks, (__bridge void *)dict);
    
    //使用0xFFFC作为空白占位符
    unichar objectReplacementChar       = 0xFFFC;
    NSString *content                   = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attributes            = [self attributesWithConfig:config];
    NSMutableAttributedString *space    = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}




@end
