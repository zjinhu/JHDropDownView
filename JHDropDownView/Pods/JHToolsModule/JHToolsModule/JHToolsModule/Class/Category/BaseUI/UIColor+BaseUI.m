//
//  UIColor+BaseUI.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIColor+BaseUI.h"

@implementation UIColor (BaseUI)
///////////////////////////////////////////主色///////////////////////////////////////////////
#pragma 主色区
+ (UIColor *)baseColor{
    return [UIColor colorWithHex:0xea5504 alpha:1.0];
}

+ (UIColor *)baseYellowColor{
    return [UIColor colorWithHex:0xFFA00A alpha:1.0];
}

+ (UIColor *)baseOrangeColor{
    return [UIColor colorWithHex:0xFC7D3D alpha:1.0];
}
///////////////////////////////////////////辅色///////////////////////////////////////////////
#pragma 辅色区
+ (UIColor *)baseBlueColor{
    return [UIColor colorWithHex:0x51a9e2 alpha:1.0];
}

+ (UIColor *)baseBlueSecondColor{
    return [UIColor colorWithHex:0x09c199 alpha:1.0];
}

+ (UIColor *)baseBlueGreenColor{
    return [UIColor colorWithHex:0x589daf alpha:1.0];
}

+ (UIColor *)baseBlueDownColor{
    return [UIColor colorWithHex:0x0080ff alpha:0.5];
}

+ (UIColor *)baseGreenColor{
    return [UIColor colorWithHex:0x3dbd7d alpha:1.0];
}

+ (UIColor *)baseRedColor{
    return [UIColor colorWithHex:0xF26363 alpha:1.0];
}

///////////////////////////////////////////文字///////////////////////////////////////////////
#pragma 文字颜色区
+ (UIColor *)baseTextColor{
    return [UIColor colorWithHex:0x333333 alpha:1.0];
}

+ (UIColor *)baseGraySixColor{
    return [UIColor colorWithHex:0x666666 alpha:1.0];
}

+ (UIColor *)baseTextMainColor{
    return [UIColor colorWithHex:0x363636 alpha:1.0];
}

+ (UIColor *)baseTextDetailColor{
    return [UIColor colorWithHex:0x878787 alpha:1.0];
}

+ (UIColor *)baseTextGrayColor{
    return [UIColor colorWithHex:0x808080 alpha:1.0];
}

+ (UIColor *)baseTextDisEnableColor{
    return [UIColor colorWithHex:0xdae0e6 alpha:1.0];
}

+ (UIColor *)baseTextGrayNonColor{
    return [UIColor colorWithHex:0xcccccc alpha:1.0];
}

+ (UIColor *)baseTileBlueColor{
    return [UIColor colorWithHex:0x0080ff alpha:1.0];
}

+ (UIColor *)baseTextHighLightOrangeColor{
    return [UIColor colorWithHex:0xfbc095 alpha:1.0];
}

///////////////////////////////////////////其他///////////////////////////////////////////////
#pragma 其他颜色区
+ (UIColor *)baseTipsColor{
    return [UIColor colorWithHex:0xfff8ea alpha:1.0];
}

+ (UIColor *)baseLineColor{
    return [UIColor colorWithHex:0xe3e3e3 alpha:1.0];
}

+ (UIColor *)baseBackgroundColor{
    return [UIColor colorWithHex:0xf5f5f5 alpha:1.0];
}

+ (UIColor *)baseWhiteColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:1.0];
}

+ (UIColor *)baseWhiteDownColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:0.5];
}

+ (UIColor *)baseNaviBackGroundColor{
    return [UIColor colorWithHex:0xfafafa alpha:1.0];
}

+ (UIColor *)baseNaviShadowColor{
    return [UIColor colorWithHex:0xcdcdcd alpha:1.0];
}

+ (UIColor *)cellHighLightColor{
    return [UIColor colorWithHex:0xeaeaea alpha:1.0];
}

////////////////////////////////////////颜色工具///////////////////////////////////////////////
#pragma 颜色工具
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *removeSharpMarkhexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:removeSharpMarkhexString];
    unsigned result = 0;
    [scanner scanHexInt:&result];
    return [self.class colorWithHex:result];
}

+ (UIColor *)colorWithHex:(NSInteger)hexColor{
    return [self colorWithHex:hexColor alpha:1.0];
}
@end
