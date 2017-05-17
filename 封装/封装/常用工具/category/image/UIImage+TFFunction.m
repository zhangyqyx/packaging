//
//  UIImage+TFFunction.m
//  封装
//
//  Created by 张永强 on 17/4/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIImage+TFFunction.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (TFFunction)

- (nullable UIColor *)TF_colorAtPoint:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    NSInteger pointX                = trunc(point.x);
    NSInteger pointY                = trunc(point.y);
    CGImageRef cgImage              = self.CGImage;
    NSUInteger width                = self.size.width;
    NSUInteger height               = self.size.height;
    CGColorSpaceRef colorSpece      = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel               = 4;
    int bytesPerRow                 = bytesPerPixel * 1;
    NSUInteger bitesPerComponent    = 8;
    unsigned char pixelData[4]      = {0,0,0,0};
    CGContextRef context            = CGBitmapContextCreate(pixelData,
                                                            1,
                                                            1,
                                                            bitesPerComponent,
                                                            bytesPerRow,
                                                            colorSpece,
                                                            kCGImageAlphaPremultipliedLast
                                                            | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpece);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red                     = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green                   = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue                    = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha                   = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)TF_singleDotImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), YES, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image                  =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark -- 水印图片
+ (instancetype)TF_waterImageWithBg:(NSString *)bg
                               logo:(NSString *)logo
                              scale:(CGFloat)scale
                             margin:(CGFloat)margin {
    UIImage *bgImage                = [UIImage imageNamed:bg];
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    //画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    //画右下角水印
    UIImage *logoImage              = [UIImage imageNamed:logo];
    CGFloat logoW                   = logoImage.size.width * scale;
    CGFloat logoH                   = logoImage.size.height * scale;
    CGFloat logoX                   = bgImage.size.width - logoW - margin;
    CGFloat logoY                   = bgImage.size.height - logoH - margin;
    CGRect rect                     = CGRectMake(logoX, logoY, logoW, logoH);
    [logoImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark -- 裁剪图片
+ (nonnull UIImage *)TF_circleImageWithImage:(nullable UIImage *)sourceImage
                               isExistBorder:(BOOL)isExistBorder
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nonnull UIColor *)borderColor {
   
    CGFloat imageSizeMin            = MIN(sourceImage.size.width, sourceImage.size.height);
    return [UIImage TF_circleImageWithImage:sourceImage imageSize:imageSizeMin isExistBorder:isExistBorder borderWidth:borderWidth borderColor:borderColor];
}
+ (UIImage *)TF_circleImageWithImageStr:(NSString *)sourceImageStr imageSize:(CGFloat)imageSize isExistBorder:(BOOL)isExistBorder borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [UIImage TF_circleImageWithImage:[UIImage imageNamed:sourceImageStr] imageSize:imageSize isExistBorder:isExistBorder borderWidth:borderWidth borderColor:borderColor];
}
+ (nonnull UIImage *)TF_circleImageWithImage:(nullable UIImage *)sourceImage
                                   imageSize:(CGFloat)imageSize
                               isExistBorder:(BOOL)isExistBorder
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nonnull UIColor*)borderColor{
    CGFloat newImageWidth;
    CGFloat newImageHeight;
    if (isExistBorder) {
        newImageWidth               = imageSize + borderWidth;
        newImageHeight              = imageSize + borderWidth;
    }else {
        newImageWidth               = imageSize;
        newImageHeight              = imageSize;
    }
    CGFloat imageSizeMin            = MIN(newImageWidth, newImageHeight);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSizeMin, imageSizeMin), NO, 2.0);
    //3. 获取当前上下文
    UIGraphicsGetCurrentContext();
    //4. 画圆圈
    UIBezierPath *bezierPath        = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageSizeMin * 0.5, imageSizeMin * 0.5) radius:(imageSizeMin-borderWidth) *0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    if (isExistBorder) {
        bezierPath.lineWidth        = borderWidth;
        [borderColor setStroke];
        [bezierPath stroke];
    }
    //5. 使用bezierPath进行剪切
    [bezierPath addClip];
    //6. 画图
    [sourceImage drawInRect:CGRectMake(0, 0, imageSizeMin, imageSizeMin)];
    //7. 从内存中创建新图片对象
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //8. 结束上下文
    UIGraphicsEndImageContext();
     return image;
}
#pragma mark -- 图片变模糊
+ (nonnull UIImage *)TF_blurImage:(nonnull UIImage *)src argument:(CGFloat)argument
{
    if (argument < 0.0 || argument > 1.0) {
        argument = 0.5;
    }
    int boxSize = (int)(argument * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = src.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (!error) {
            error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        }
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

#pragma mark -- 裁剪图片
+ (nonnull UIImage *)image:(nonnull UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
+ (nonnull UIImage *)handleImage:(nonnull UIImage *)originalImage withSize:(CGSize)size
{
    CGSize originalsize = [originalImage size];
    //    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        //        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        //        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}



@end
