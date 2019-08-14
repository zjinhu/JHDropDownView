//
//  JHBaseWebViewController.h
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHBaseViewController.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface JHBaseWebViewController : JHBaseViewController

@property (nonatomic, strong) UIProgressView *loadingProgressView;//进度条
@property (nonatomic, strong) UIButton *reloadBtn;//重新加载的按钮

@property (nonatomic, strong) WKWebView *webView;     //webview
@property (nonatomic, strong) NSString *navTitle;     //页面标题
@property (nonatomic, assign) BOOL supportAutoLogin;  //默认不支持
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *agent;     //自定义UA，不传为默认
 
- (instancetype)initWithLoadURL:(NSString *)urlString;

- (instancetype)initWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url cookie:(NSDictionary *)cookie;

- (instancetype)initWithURLRequest:(NSURLRequest *)requst;

- (void)loadRequest;

- (void)cleanAllWebsiteDataStore;

- (void)closeVC;
@end
