//
//  WKDelegateController.h
//  IKToolsModule
//
//  Created by HU on 2018/8/7.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface WeakScriptMessageDelegate : NSObject <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKScriptMessageHandler> delegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
@end
