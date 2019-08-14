//
//  UIImage+BaseUI.h
//  IKToolsModule
//
//  Created by HU on 2018/7/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (BaseUI)
+ (UIImage *)loadImageNamed:(NSString *)name;
//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//渐变色图片
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
/**
 *  根据CIImage生成指定大小的UIImage
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;


+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (UIImage *)cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (UIImage *)scaleToSize:(CGSize)size;
@end
