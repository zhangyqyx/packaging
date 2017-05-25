//
//  CoreTextLinkData.h
//  CoreText
//
//  Created by 张永强 on 17/5/24.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject

/**标题 */
@property (nonatomic , strong)NSString *title;
/**链接url */
@property (nonatomic , strong)NSString *url;
/**长度 */
@property (nonatomic , assign)NSRange range;



@end
