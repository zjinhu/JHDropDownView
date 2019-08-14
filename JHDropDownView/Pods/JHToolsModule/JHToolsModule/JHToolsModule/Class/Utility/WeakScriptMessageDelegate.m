//
//  WKDelegateController.m
//  IKToolsModule
//
//  Created by HU on 2018/8/7.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@interface WeakScriptMessageDelegate ()

@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _delegate = scriptDelegate;
    }
    return self;
}
 
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end
