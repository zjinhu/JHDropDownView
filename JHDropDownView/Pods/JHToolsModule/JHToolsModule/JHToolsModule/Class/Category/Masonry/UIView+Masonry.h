//
//  UIView+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
#import "UIGestureRecognizer+Block.h"
@interface UIView (Masonry)

/**
 *  点击手势
 */
@property (nonatomic, strong, readonly) UITapGestureRecognizer *masTapGesture;

/**
 *
 *    长按手势
 */
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *masLongGesure;



/**
 * 快速创建一个View，设置背景颜色，布局
 
 @param backColor   背景颜色
 @param supView     父视图
 @param constraints 布局
 @return 返回一个View
 */
+(instancetype)masViewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(JHConstrainMaker)constraints;

/**
 * 快速创建一个View，设置背景颜色，布局，点击事件
 
 @param backColor 背景颜色
 @param constraints 布局
 @param supView     父视图
 @param onTap 点击事件
 @return 返回一个View
 */
+(instancetype)masViewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(JHConstrainMaker)constraints
                              onTap:(JHTapGestureBlock)onTap;


/**
 *
 *    在回调中添加一个tap手势。它将自动打开用户界面为YES。
 *
 *    @param onTaped    The callback block when taped.
 */
- (void)masAddTapGestureWithCallback:(JHTapGestureBlock)onTaped;

/**
 *
 *    添加长按手势与回调。它将自动打开用户界面为YES。
 *
 *    @param onLongPressed    The long press callback when long pressed.
 */
- (void)masAddLongGestureWithCallback:(JHLongGestureBlock)onLongPressed;

@end
