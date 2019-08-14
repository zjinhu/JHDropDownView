//
//  UIWebView+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
@interface UIWebView (Masonry)
/**
 *
 *    创建一个没有布局的web视图。
 *
 *    @param delegate    UIWebViewDelegate
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)delegate;

/**
 *
 *    创建一个具有超视图的web视图，并添加边缘作为布局。
 *
 *    @param delegate    UIWebViewDelegate
 *    @param superView    The super view of web view.
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)delegate superView:(UIView *)superView;

/**
 *
 *    创建一个具有超视图的web视图，并添加边缘作为布局。
 *
 *    @param delegate    UIWebViewDelegate
 *    @param superView    The super view of web view.
 *    @param edges            The edges inset.
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)delegate
                             superView:(UIView *)superView
                                 edges:(UIEdgeInsets)edges;

/**
 *
 *    使用超视图创建web视图并指定布局。
 *
 *    @param delegate    UIWebViewDelegate
 *    @param superView    The super view of web view.
 *    @param constraints    The constraints added to the web view.
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)delegate
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints;
@end
