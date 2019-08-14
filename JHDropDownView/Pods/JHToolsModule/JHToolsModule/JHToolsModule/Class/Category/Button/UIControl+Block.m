//
//  UIControl+Block.m
//  AFNetworking
//
//  Created by HU on 2018/8/7.
//

#import "UIControl+Block.h"
#import <objc/runtime.h>

static void *BlockKey = @"BlockKey";

@implementation UIControl (Block)
///添加点击事件
- (void)addActionforControlEvents:(UIControlEvents)controlEvents Completion:(void (^)(void))completion {
    [self addTarget:self action:@selector(blockAction) forControlEvents:controlEvents];
    
    void (^block)(void) = ^{
        completion();
    };
    objc_setAssociatedObject(self, BlockKey, block, OBJC_ASSOCIATION_COPY);
    
}

- (void)blockAction {
    void (^block)(void) = objc_getAssociatedObject(self, BlockKey);
    block();
}
@end
