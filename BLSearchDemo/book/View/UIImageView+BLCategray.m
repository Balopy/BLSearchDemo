//
//  UIImageView+BLCategray.m
//  OilReading
//
//  Created by 王春龙 on 2018/1/11.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "UIImageView+BLCategray.h"

@implementation UIImage (BLCategray)



/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        //以下是对手机32位、64位的处理（由网友评论区拿到的：小怪兽饲养猿）
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            CFRelease(imageProperties);
        }
        
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}


- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

/*! 带边框的图片, name 本地图片路径
 borderWidth 边宽,
 borderColor 边色 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    /// 1.加载原图
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:name]];
    UIImage *oldImage = [UIImage imageWithData:data];
    
    /// 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    /// 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /// 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; /// 大圆半径
    CGFloat centerX = bigRadius; /// 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); /// 画圆
    
    /// 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    /// 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    /// 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    /// 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /// 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*! 带边框的图片, borderWidth 边宽, borderColor 边色 */
+ (instancetype)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    /// 1.加载原图
    UIImage *oldImage = image;
    
    /// 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    /// 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /// 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; /// 大圆半径
    CGFloat centerX = bigRadius; /// 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); /// 画圆
    
    /// 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    /// 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    /// 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    /// 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /// 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


/*! 带边框的图片, borderWidth 边宽, borderColor 边色 */
- (UIImage *)circleImageWithSize:(CGSize)size radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    
    /// 2.开启上下文
    CGFloat imageW = size.width + 2 * borderWidth;
    CGFloat imageH = size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    /// 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /// 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = radius+borderWidth; /// 大圆半径
    CGFloat centerX = bigRadius; /// 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); /// 画圆
    
    /// 5.小圆
    CGFloat smallRadius = radius;//bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    /// 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    /// 6.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, size.width, size.height)];
    
    /// 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /// 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}



/**
 *  返回主bundle的图片对象
 *
 */
+(UIImage *)imageFromMainBundleWithName:(NSString *)name
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    return [UIImage imageWithContentsOfFile:imagePath];
    
}

/** UIImage * 图片切圆, center中心点  radius 半径 */
- (CAShapeLayer *)circleImageWithImage:(UIImageView *)image center:(CGPoint)center radius:(CGFloat)radius
{
    ///创建圆形遮罩，把用户头像变成圆形
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    image.layer.mask = shape;
    
    return shape;
}


@end

