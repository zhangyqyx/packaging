//
//  CoreTextData.h
//  CoreText
//
//  Created by 张永强 on 17/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

//用于保存由CTFrameParser类生成的CTFrameRef实例，以及CTFrameRef绘制需要的高度
@interface CoreTextData : NSObject

/**CTFrameRef实例 */
@property (nonatomic , assign)CTFrameRef ctFrame;
/**高度 */
@property (nonatomic , assign)CGFloat height;
/**图片数组 */
@property (nonatomic , strong)NSArray *imageArray;
/** 链接数组 */
@property (strong,nonatomic)NSArray *linkArray;


@end
