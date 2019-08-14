//
//  WKWebView+Masonry.h
//  IKToolsModule
//
//  Created by HU on 2018/7/31.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "JHMasonryTool.h"
@interface WKWebView (Masonry)
/**
 *
 *    创建一个没有布局的web视图。
 *
 *    @param UIDelegate    UIDelegate
  *    @param navDelegate    navigationDelegate
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate;

/**
 *
 *    创建一个具有超视图的web视图，并添加边缘作为布局。
 *
 *    @param UIDelegate    UIDelegate
 *    @param navDelegate    navigationDelegate
 *    @param superView    The super view of web view.
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate
                             superView:(UIView *)superView;

/**
 *
 *    创建一个具有超视图的web视图，并添加边缘作为布局。
 *
 *    @param UIDelegate    UIDelegate
 *    @param navDelegate    navigationDelegate
 *    @param superView    The super view of web view.
 *    @param edges            The edges inset.
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate
                             superView:(UIView *)superView
                                 edges:(UIEdgeInsets)edges;

/**
 *
 *    使用超视图创建web视图并指定布局。
 *
 *    @param UIDelegate    UIDelegate
 *    @param navDelegate    navigationDelegate
 *    @param superView    The super view of web view.
 *    @param constraints    The constraints added to the web view.
 *
 *    @return UIWebView的实例
 */
+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate
                                config:(WKWebViewConfiguration*)config
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints;
@end
