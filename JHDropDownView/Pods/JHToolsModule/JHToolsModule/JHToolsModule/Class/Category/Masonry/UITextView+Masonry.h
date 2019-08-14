//
//  UITextView+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"


typedef void(^TextViewHeightDidChangedBlock)(CGFloat currentTextViewHeight);

@interface UITextView (Masonry)
/**
 * 快速创建一个UItextView,设置字体大小，字体颜色，placeText,placeColor，masonry布局
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param placeColor placeText
 @param placeText placeColor
 @param constraints masonry布局
 @param superView 父视图
 @return textView
 */
+(instancetype)masTextViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints;


/**
 * 快速创建一个UItextView,设置字体大小，字体颜色，边框颜色，边框大小，圆角，placeText,placeColor，masonry布局
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param borderColor 边框颜色
 @param borderWidth 边框大小
 @param cornerRadiu 圆角
 @param placeColor placeText
 @param placeText placeColor
 @param constraints masonry布局
 @param superView 父视图
 @return textView
 */
+(instancetype)masTextViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                           borderColor:(UIColor *)borderColor
                           borderWidth:(CGFloat)borderWidth
                           cornerRadiu:(CGFloat)cornerRadiu
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints;

- (void)masTextViewsSetPlaceholderWithText:(NSString *)text Color:(UIColor *)color;
- (void)masTextViewsSetPlaceholderWithAttributedText:(NSAttributedString *)attributedPlaceholder;


/* 占位文字 */
@property (nonatomic, copy) NSString *masPlaceholder;
/* 占位文字颜色 */
@property (nonatomic, strong) UIColor *masPlaceholderColor;
/* 最大高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat masMaxHeight;
/* 最小高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat masMinHeight;
@property (nonatomic, copy) TextViewHeightDidChangedBlock masTextViewHeightDidChanged;
/* 获取图片数组 */
- (NSArray *)masGetImages;
/* 自动高度的方法，maxHeight：最大高度 */
- (void)masAutoHeightWithMaxHeight:(CGFloat)maxHeight;
/* 自动高度的方法，maxHeight：最大高度， textHeightDidChanged：高度改变的时候调用 */
- (void)masAutoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(TextViewHeightDidChangedBlock)textViewHeightDidChanged;
/* 添加一张图片 image:要添加的图片 */
- (void)masAddImage:(UIImage *)image;
/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)masAddImage:(UIImage *)image size:(CGSize)size;
/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)masInsertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index;
/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)masAddImage:(UIImage *)image multiple:(CGFloat)multiple;
/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)masInsertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index;
@end
