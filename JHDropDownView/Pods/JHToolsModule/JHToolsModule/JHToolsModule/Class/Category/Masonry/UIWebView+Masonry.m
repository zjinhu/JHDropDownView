//
//  UIWebView+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIWebView+Masonry.h"

@implementation UIWebView (Masonry)

+ (instancetype)masWebViewWithDelegate:(id)delegate {
    return [self masWebViewWithDelegate:delegate superView:nil];
}

+ (instancetype)masWebViewWithDelegate:(id)delegate superView:(UIView *)superView {
    return [self masWebViewWithDelegate:delegate superView:superView edges:UIEdgeInsetsZero];
}

+ (instancetype)masWebViewWithDelegate:(id)delegate superView:(UIView *)superView edges:(UIEdgeInsets)edges {
    return [self masWebViewWithDelegate:delegate superView:superView constraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(superView).insets(edges);
    }];
}

+ (instancetype)masWebViewWithDelegate:(id)delegate
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints {
    UIWebView *webView = [[UIWebView alloc] init];
    
    // 自适应屏幕大小进行缩放
    webView.userInteractionEnabled = YES;
    webView.delegate = delegate;
    webView.scalesPageToFit = YES;
    webView.scrollView.showsVerticalScrollIndicator = NO;
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
