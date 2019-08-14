//
//  UIButton+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
/**
 * Button点击事件Block
 *
 */
typedef void(^JHButtonActionBlock)(id sender);

@interface UIButton (Masonry)


/**
 *  按钮的block点击事件
 */
@property (nonatomic, copy) JHButtonActionBlock masBtnOnTouchUp;


/**
 快速创建UIButton
 @param touchUp         点击事件
 @return                返回一个button
 */
+(instancetype)masButtonWithOnTouchUp:(JHButtonBlock)touchUp;

/**
 * 快速创建UIButton
 * @param supView         父视图
 * @param constaints      Marsonry布局
 * @param touchUp         点击事件
 * @return                返回一个button
 */
+(instancetype)masButtonWithSupView:(UIView *)supView
                        constraints:(JHConstrainMaker)constaints
                            touchUp:(JHButtonBlock)touchUp;


/**
 * 快速创建UIButton，设置：标题，父视图，Marsonry布局
 
 @param title    圆角
 @param superView         父视图
 @param constraints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个button
 */
+ (instancetype)masButtonWithTitle:(NSString *)title
                         superView:(UIView *)superView
                       constraints:(JHConstrainMaker)constraints
                           touchUp:(JHButtonBlock)touchUp;

/**
 * 快速创建UIButton，设置：默认图片，圆角，父视图，Marsonry布局
 
 @param cornerRadius    圆角
 @param supView         父视图
 @param constaints      Marsonry布局
 @param touchUp         点击事件
 @return                返回一个button
 */
+(instancetype)masButtonWithNorImage:(id)norImage
                        cornerRadius:(CGFloat)cornerRadius
                             supView:(UIView *)supView
                         constraints:(JHConstrainMaker)constaints
                             touchUp:(JHButtonBlock)touchUp;

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
                          touchUp:(JHButtonBlock)touchUp;

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
                          touchUp:(JHButtonBlock)touchUp;


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
                          touchUp:(JHButtonBlock)touchUp;

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
                          touchUp:(JHButtonBlock)touchUp;


@end
