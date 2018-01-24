//
//  UIImageView+BLCategray.h
//  OilReading
//
//  Created by 王春龙 on 2018/1/11.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BLCategray)

/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;

- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  返回拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


/*! 带边框的图片, name 本地图片路径
 borderWidth 边宽,
 borderColor 边色 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/*! 带边框的图片, borderWidth 边宽, borderColor 边色 */
+ (instancetype)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/*! 带边框的图片,size 图片大小, radius 半径 borderWidth 边宽, borderColor 边色 */
- (UIImage *)circleImageWithSize:(CGSize)size radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+(UIImage *)imageFromMainBundleWithName:(NSString *)name;


/** UIImage * 图片切圆, center中心点  radius 半径 */
- (CAShapeLayer *)circleImageWithImage:(UIImageView *)image center:(CGPoint)center radius:(CGFloat)radius;
@end

