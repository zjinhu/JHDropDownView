//
//  UILabel+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
@interface UILabel (Masonry)
/**
 *创建一个Label,设置字体大小
 @param                 fontsize 字体大小
 @return                UILabel
 */
+(instancetype)masLabelWithFontSize:(CGFloat)fontsize;
/**
 *创建一个Label,设置字体大小
 @param                 font 字体大小
 @return                UILabel
 */
+(instancetype)masLabelWithFont:(UIFont *)font;

/**
 *快速创建一个Label,字体大小,父视图,masonry布局
 
 @param fontsize            字体大小
 @param superView       父视图
 @param constraints     masonry布局
 @return label
 */
+(instancetype)masLabelWithFontSize:(CGFloat)fontsize
                          textColor:(UIColor *)textColor
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints;
/**
 *快速创建一个Label,字体大小,父视图,masonry布局
 
 @param font           字体大小
 @param superView       父视图
 @param constraints     masonry布局
 @return label
 */
+(instancetype)masLabelWithFont:(UIFont *)font
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(JHConstrainMaker)constraints;
/**
 *快速创建一个label,字体大小,文本
 
 @param                 fontsize 字体大小
 @param                 text 文本
 @return                label
 */
+(instancetype)masLabelWithFontSize:(CGFloat)fontsize
                               text:(NSString *)text;

/**
 *快速创建一个label,字体大小,文本
 
 @param                 font 字体大小
 @param                 text 文本
 @return                label
 */
+(instancetype)masLabelWithFont:(UIFont *)font
                           text:(NSString *)text;

/**
 *快速创建一个Label,字体大小,文本,父视图,masonry布局
 
 @param                 fontsize 字体大小
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)masLabelWithFontSize:(CGFloat)fontsize
                               text:(NSString *)text
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints;
/**
 *快速创建一个Label,字体大小,文本,父视图,masonry布局
 
 @param                 font 字体大小
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)masLabelWithFont:(UIFont *)font
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(JHConstrainMaker)constraints;
/**
 *快速创建一个Label,字体大小,文本,行数,父视图,masonry布局
 
 @param                 fontsize 字体大小
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)masLabelWithFontSize:(CGFloat)fontsize
                              lines:(NSInteger)lines
                               text:(NSString *)text
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints;


/**
 *快速创建一个Label,字体大小,文本,字体颜色,行数,父视图,masonry布局
 
 @param                 font 字体UIFont
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)masLabelWithFont:(UIFont *)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(JHConstrainMaker)constraints;

/**
 *快速创建一个Label,字体大小,文本,字体颜色,行数,父视图,masonry布局
 
 @param                 fontsize 字体大小
 @param                 lines 行数
 @param                 text 文本
 @param                 superView 父视图
 @param                 constraints masonry布局
 @return                label
 */
+(instancetype)masLabelWithFontSize:(CGFloat)fontsize
                              lines:(NSInteger)lines
                               text:(NSString *)text
                          textColor:(UIColor *)textColor
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints;

/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;

/**
 *获取自定义样式或者普通UILabel高度
 */
+ (CGFloat)getHeightWithText:(NSString*)str width:(CGFloat)width;

+ (CGFloat)getHeightWithAttribute:(NSMutableAttributedString*)attributedString width:(CGFloat)width;

/**
 *设置行间距并且计算高度
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
@end
