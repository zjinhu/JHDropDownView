//
//  UIColor+BaseUI.h
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BaseUI)
///////////////////////////////////////////主色///////////////////////////////////////////////
/**
 APP主色调 0xea5504
 */
+ (UIColor *)baseColor;
/**
 基础黄色 色调 0xFF8500
 */
+ (UIColor *)baseYellowColor;
/**
 色调 0xFC7D3D
 */
+ (UIColor *)baseOrangeColor;
///////////////////////////////////////////辅色///////////////////////////////////////////////
/**
 基础蓝色 色调 0x51a9e2
 */
+ (UIColor *)baseBlueColor;
/**
 基础蓝色 色调 0x09c199
 */
+ (UIColor *)baseBlueSecondColor;
/**
 色调 0x589daf
 */
+ (UIColor *)baseBlueGreenColor;
/**
 蓝色按下 色调 0x0080ff
 */
+ (UIColor *)baseBlueDownColor;
/**
 基础绿色 色调 0x3dbd7d
 */
+ (UIColor *)baseGreenColor;
/**
 基础红色 色调 0xF26363
 */
+ (UIColor *)baseRedColor;
///////////////////////////////////////////文字///////////////////////////////////////////////
/**
 色调 0x333333
 */
+ (UIColor *)baseTextColor;
/**
 色调 0x808080
 */
+ (UIColor *)baseTextGrayColor;
/**
 文本置灰 不可点击 色调 0xcccccc
 */
+ (UIColor *)baseTextGrayNonColor;

/**
 色调 0x666666
 */
+ (UIColor *)baseGraySixColor;
/**
 色调 0x363636
 */
+ (UIColor *)baseTextMainColor;
/**
 色调 0x878787
 */
+ (UIColor *)baseTextDetailColor;
/**
 文本 不可点击 色调 0xdae0e6
 */
+ (UIColor *)baseTextDisEnableColor;
/**
 标题 色调 0x0080ff
 */
+ (UIColor *)baseTileBlueColor;
/**
 字体 色调 0xfbc095
 */
+ (UIColor *)baseTextHighLightOrangeColor;
///////////////////////////////////////////其他///////////////////////////////////////////////
/**
 标签浅黄 色调 0xfff8ea
 */
+ (UIColor *)baseTipsColor;
/**
 线 色调 0xe3e3e3
 */
+ (UIColor *)baseLineColor;
/**
 色调 0xf5f5f5
 */
+ (UIColor *)baseBackgroundColor;
/**
 白色 色调 0xFFFFFF
 */
+ (UIColor *)baseWhiteColor;
/**
 白色按下 色调 0xFFFFFF 透明度0.5
 */
+ (UIColor *)baseWhiteDownColor;
/**
 导航栏 色调 0xfafafa
 */
+ (UIColor *)baseNaviBackGroundColor;
/**
 导航栏 线 色调 0xcdcdcd
 */
+ (UIColor *)baseNaviShadowColor;
/**
 cell分割线 高亮色调 0xeaeaea
 */
+ (UIColor *)cellHighLightColor;

//16进制色值转换
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHex:(NSInteger)hexColor;
@end
