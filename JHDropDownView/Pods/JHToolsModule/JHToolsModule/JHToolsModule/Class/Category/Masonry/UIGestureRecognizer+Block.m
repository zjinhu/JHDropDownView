//
//  UIGestureRecognizer+Block.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>

static const void *JHGestureKey = "JHGestureKey";
static const void *JHTapGestureKey = "JHTapGestureKey";
static const void *JHLongGestureKey = "JHLongGestureKey";

@implementation UIGestureRecognizer (Block)

- (JHGestureBlock)onGesture {
    return objc_getAssociatedObject(self, JHGestureKey);
}

- (void)setOnGesture:(JHGestureBlock)onGesture {
    objc_setAssociatedObject(self,
                             JHGestureKey,
                             onGesture,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(private_onGesture:)];
    
    if (onGesture) {
        [self addTarget:self action:@selector(private_onGesture:)];
    }
}

- (JHTapGestureBlock)onTaped {
    return objc_getAssociatedObject(self, JHTapGestureKey);
}

- (void)setOnTaped:(JHTapGestureBlock)onTaped {
    objc_setAssociatedObject(self,
                             JHTapGestureKey,
                             onTaped,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(private_onTaped:)];
    
    if (onTaped) {
        [self addTarget:self action:@selector(private_onTaped:)];
    }
}

- (JHLongGestureBlock)onLongPressed {
    return objc_getAssociatedObject(self, JHLongGestureKey);
}

- (void)setOnLongPressed:(JHLongGestureBlock)onLongPressed {
    objc_setAssociatedObject(self,
                             JHLongGestureKey,
                             onLongPressed,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(private_onLongPressed:)];
    
    if (onLongPressed) {
        [self addTarget:self action:@selector(private_onLongPressed:)];
    }
}

#pragma mark - Private
- (void)private_onGesture:(UIGestureRecognizer *)sender {
    JHGestureBlock block = [self onGesture];
    
    if (block) {
        block(sender);
    }
}

- (void)private_onTaped:(UITapGestureRecognizer *)sender {
    JHTapGestureBlock block = [self onTaped];
    
    if (block) {
        block(sender);
    }
}

- (void)private_onLongPressed:(UILongPressGestureRecognizer *)sender {
    JHLongGestureBlock block = [self onLongPressed];
    
    if (block) {
        block(sender);
    }
}

@end
