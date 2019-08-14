//
//  UIImageView+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
@interface UIImageView (Masonry)
/**
 *  快速创建一个 UIImageView
 */
+(instancetype)masImageView;

/**
 *  快速创建一个 UIImageView,设置图片
 */
+(instancetype)masImageViewWithImage:(id)image;
/**
 *  快速创建一个 UIImageView,设置图片,父视图,Masonry约束
 */
+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         constraints:(JHConstrainMaker)constraints;
/**
 *  快速创建一个 UIImageView,设置图片,父视图, Masonry约束,点击事件
 */
+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         constraints:(JHConstrainMaker)constraints
                          imgViewTap:(JHTapGestureBlock)imgViewTap;

/**
 *  快速创建一个 UIImageView,设置图片,父视图,填充模式,Masonry约束,是否剪切
 */
+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         contentMode:(UIViewContentMode)contentMode
                              isClip:(BOOL)isClip
                         constraints:(JHConstrainMaker)constraints;

/**
 *  快速创建一个 UIImageView
 *  @param image        图片或图片名
 *  @param superView    父视图
 *  @param isClip       是否剪切
 *  @param constraints  Masonry约束
 *  @param imgViewTap   点击事件
 */
+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         contentMode:(UIViewContentMode)contentMode
                              isClip:(BOOL)isClip
                         constraints:(JHConstrainMaker)constraints
                          imgViewTap:(JHTapGestureBlock)imgViewTap;


/**
 *  重新绘制图片,避免图层混合
 */
+(UIImage *)masReDrawImage:(UIImage *)image size:(CGSize)size;
@end
