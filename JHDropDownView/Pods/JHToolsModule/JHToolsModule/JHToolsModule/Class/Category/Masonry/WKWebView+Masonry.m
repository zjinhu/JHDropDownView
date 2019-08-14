//
//  WKWebView+Masonry.m
//  IKToolsModule
//
//  Created by HU on 2018/7/31.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "WKWebView+Masonry.h"

@implementation WKWebView (Masonry)

+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate{
    return [self masWebViewWithDelegate:UIDelegate navDelegate:navDelegate superView:nil];
}

+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate
                             superView:(UIView *)superView{
    return [self masWebViewWithDelegate:UIDelegate navDelegate:navDelegate superView:superView edges:UIEdgeInsetsZero];
}

+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate
                             superView:(UIView *)superView
                                 edges:(UIEdgeInsets)edges{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.preferences = [[WKPreferences alloc]init];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    config.allowsInlineMediaPlayback = YES;
    config.selectionGranularity = YES;
    return [self masWebViewWithDelegate:UIDelegate navDelegate:navDelegate config:config superView:superView constraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(superView).insets(edges);
    }];
}

+ (instancetype)masWebViewWithDelegate:(id)UIDelegate
                           navDelegate:(id)navDelegate
                                config:(WKWebViewConfiguration*)config
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    // 自适应屏幕大小进行缩放
    webView.userInteractionEnabled = YES;
 
    [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [webView setNavigationDelegate:navDelegate];
    [webView setUIDelegate:UIDelegate];
    [webView setMultipleTouchEnabled:YES];
    [webView setAutoresizesSubviews:YES];
    [webView.scrollView setAlwaysBounceVertical:YES];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.allowsBackForwardNavigationGestures = YES;
    [superView addSubview:webView];
    
    if (superView) {
        if (constraints) {
            [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                constraints(make);
            }];
        } else {
            [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(superView);
            }];
        }
    }
    
    return webView;
}
@end
