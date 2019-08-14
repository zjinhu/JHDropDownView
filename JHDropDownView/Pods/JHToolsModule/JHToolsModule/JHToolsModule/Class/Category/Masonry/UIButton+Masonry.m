//
//  UIButton+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIButton+Masonry.h"
#import <objc/runtime.h>
// 判断它是否是空字符串。
#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

static const void *JHButtonTouchUpKey     = "JHButtonTouchUpKey";
@implementation UIButton (Masonry)

+(instancetype)masButtonWithOnTouchUp:(JHButtonBlock)touchUp{
    return [self masButtonWithOnTouchUp:touchUp];
}


+(instancetype)masButtonWithSupView:(UIView *)supView
                        constraints:(JHConstrainMaker)constaints
                            touchUp:(JHButtonBlock)touchUp{
    return [self masButtonWithNorImage:nil
                          cornerRadius:0
                               supView:supView
                           constraints:constaints
                               touchUp:touchUp];
}


+ (instancetype)masButtonWithTitle:(NSString *)title
                         superView:(UIView *)superView
                       constraints:(JHConstrainMaker)constraints
                           touchUp:(JHButtonBlock)touchUp
{
    return [self masButtonWithTitle:title
                         titleColor:nil
                          backColor:nil
                           fontSize:0
                       cornerRadius:0
                            supView:superView
                        constraints:constraints
                            touchUp:touchUp];
}

+(instancetype)masButtonWithNorImage:(id)norImage
                        cornerRadius:(CGFloat)cornerRadius
                             supView:(UIView *)supView
                         constraints:(JHConstrainMaker)constaints
                             touchUp:(JHButtonBlock)touchUp{
    return [self masButtonWithTitle:nil
                         titleColor:nil
                           norImage:norImage
                      selectedImage:nil
                          backColor:nil
                           fontSize:0
                             weight:UIFontWeightRegular
                       cornerRadius:cornerRadius
                            supView:supView
                        constraints:constaints
                            touchUp:touchUp];
}

/**
 * 快速创建UIButton，设置：标题，标题颜色，背景颜色，字体大小，是否加粗，圆角，父视图，Marsonry布局
 
 @param title           标题
 @param titleColor      标题颜色
 @param backColor       背景颜色
 @param fontSize        字体大小
 @param cornerRadius    圆角
 @param supView         父视图
 @param constaints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个button
 */
+(instancetype)masButtonWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                        backColor:(UIColor *)backColor
                         fontSize:(CGFloat)fontSize
                     cornerRadius:(CGFloat)cornerRadius
                          supView:(UIView *)supView
                      constraints:(JHConstrainMaker)constaints
                          touchUp:(JHButtonBlock)touchUp{
    return [self masButtonWithTitle:title
                         titleColor:titleColor
                           norImage:nil
                      selectedImage:nil
                          backColor:backColor
                           fontSize:fontSize
                             weight:UIFontWeightRegular
                       cornerRadius:cornerRadius
                            supView:supView
                        constraints:constaints
                            touchUp:touchUp];
}

/**
 * 快速创建UIButton，设置：标题，标题颜色，背景颜色，字体大小，是否加粗，圆角，父视图，Marsonry布局
 
 @param title           标题
 @param titleColor      标题颜色
 @param backColor       背景颜色
 @param fontSize        字体大小
 @param weight          字重
 @param cornerRadius    圆角
 @param supView         父视图
 @param constaints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个button
 */
+(instancetype)masButtonWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                        backColor:(UIColor *)backColor
                         fontSize:(CGFloat)fontSize
                           weight:(UIFontWeight)weight
                     cornerRadius:(CGFloat)cornerRadius
                          supView:(UIView *)supView
                      constraints:(JHConstrainMaker)constaints
                          touchUp:(JHButtonBlock)touchUp{
    return [self masButtonWithTitle:title
                         titleColor:titleColor
                           norImage:nil
                      selectedImage:nil
                          backColor:backColor
                           fontSize:fontSize
                             weight:weight
                       cornerRadius:cornerRadius
                            supView:supView
                        constraints:constaints
                            touchUp:touchUp];
}

/**
 * 快速创建UIButton，设置：标题，标题颜色，默认图片，选中的图片，背景颜色，字体大小，是否加粗，圆角，父视图，Marsonry布局
 
 @param title           标题
 @param titleColor      标题颜色
 @param norImage        默认图片
 @param selectImage        选中的图片
 @param backColor       背景颜色
 @param fontSize        字体大小
 @param weight          字重
 @param cornerRadius    圆角
 @param supView         父视图
 @param constaints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个button
 */
+(instancetype)masButtonWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                         norImage:(id)norImage
                    selectedImage:(id)selectImage
                        backColor:(UIColor *)backColor
                         fontSize:(CGFloat)fontSize
                           weight:(UIFontWeight)weight
                     cornerRadius:(CGFloat)cornerRadius
                          supView:(UIView *)supView
                      constraints:(JHConstrainMaker)constaints
                          touchUp:(JHButtonBlock)touchUp{
    return [self masButtonWithTitle:title
                         titleColor:titleColor
                           norImage:norImage
                      selectedImage:selectImage
                          backColor:backColor
                           fontSize:fontSize
                             weight:weight
                        borderWidth:0
                        borderColor:nil
                       cornerRadius:cornerRadius
                            supView:supView
                        constraints:constaints
                            touchUp:touchUp];
}
/**
 * 快速创建UIButton，设置：标题，标题颜色，默认图片，选中的图片，背景颜色，字体大小，是否加粗，边框宽度，边框颜色，圆角，父视图，Marsonry布局
 
 @param title           标题
 @param titleColor      标题颜色
 @param norImage        默认图片
 @param selectImage        选中的图片
 @param backColor       背景颜色
 @param fontSize        字体大小
 @param weight          字重
 @param borderWidth     边框宽度
 @param borderColor     边框颜色
 @param cornerRadius    圆角
 @param supView         父视图
 @param constaints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个 button
 */
+(instancetype)masButtonWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                         norImage:(id)norImage
                    selectedImage:(id)selectImage
                        backColor:(UIColor *)backColor
                         fontSize:(CGFloat)fontSize
                           weight:(UIFontWeight)weight
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius
                          supView:(UIView *)supView
                      constraints:(JHConstrainMaker)constaints
                          touchUp:(JHButtonBlock)touchUp{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.masBtnOnTouchUp = touchUp;
    
    if (!kIsEmptyString(title)) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    UIImage *normalImage = nil;
    if ([norImage isKindOfClass:[NSString class]]) {
        normalImage = [UIImage imageNamed:norImage];
    }else if([norImage isKindOfClass:[UIImage class]]){
        normalImage = norImage;
    }
    
    UIImage *seleImage = nil;
    if ([selectImage isKindOfClass:[NSString class]]) {
        seleImage = [UIImage imageNamed:selectImage];
    }else if([selectImage isKindOfClass:[UIImage class]]){
        seleImage = selectImage;
    }
    
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (seleImage) {
        [button setImage:seleImage forState:UIControlStateSelected];
    }
    
    if (fontSize > 0) {
        button.titleLabel.font =  [UIFont systemFontOfSize:fontSize weight:weight];
    }
    
    
    button.backgroundColor = backColor ? backColor : [UIColor whiteColor];
    button.titleLabel.backgroundColor = button.backgroundColor;
    button.titleLabel.layer.masksToBounds = YES;
    button.layer.masksToBounds = YES;
    
    button.layer.cornerRadius = cornerRadius;
    if (borderWidth) {
        button.layer.borderWidth = borderWidth;
        button.layer.borderColor = borderColor.CGColor;
    }
    
    [supView addSubview:button];
    
    if (supView && constaints) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            constaints(make);
        }];
    }
    
    return button;
}


-(JHButtonActionBlock)masBtnOnTouchUp{
    return objc_getAssociatedObject(self, JHButtonTouchUpKey);
}

-(void)setMasBtnOnTouchUp:(JHButtonActionBlock)masBtnOnTouchUp{
    objc_setAssociatedObject(self, JHButtonTouchUpKey, masBtnOnTouchUp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(private_btnOnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    if (masBtnOnTouchUp) {
        [self addTarget:self action:@selector(private_btnOnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
}



-(void)private_btnOnTouchUp:(id)sender{
    JHButtonActionBlock block  = [self masBtnOnTouchUp];
    if (block) {
        block(sender);
    }
}
@end
