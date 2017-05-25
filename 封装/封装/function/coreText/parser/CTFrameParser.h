//
//  CTFrameParser.h
//  CoreText
//
//  Created by 张永强 on 17/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"

//用于生成最后绘制界面需要的CTFrameRef
@interface CTFrameParser : NSObject

/**
 给内容设置配置信息
 @param content 传入的内容
 @param config 配置信息
 @return 配置后的结果
 */
+ (CoreTextData *)parseContent:(NSString *)content
                        config:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content
                                  config:(CTFrameParserConfig *)config;
//配置信息
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

/**
 为模板文件设置配置信息
 @param path 文件路径
 @param config 配置信息
 @return 配置后的结果
 */
+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config;





@end
