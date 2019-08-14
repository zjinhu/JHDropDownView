//
//  UIView+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIView+Masonry.h"
#import <objc/runtime.h>

static const void *TapGestureKey = "TapGestureKey";
static const void *LongGestureKey = "LongGestureKey";
@implementation UIView (Masonry)

/**
 * 快速创建一个View，设置背景颜色，布局，点击事件
 
 @param backColor 背景颜色
 @param constraints 布局
 @return 返回一个View
 */
+(instancetype)masViewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(JHConstrainMaker)constraints
{
    return [self masViewWithBackColor:backColor supView:supView constraints:constraints onTap:nil];
}

/**
 * 快速创建一个View，设置背景颜色，布局，点击事件
 
 @param backColor 背景颜色
 @param constraints 布局
 @param onTap 点击事件
 @return 返回一个View
 */
+(instancetype)masViewWithBackColor:(UIColor *)backColor
                            supView:(UIView *)supView
                        constraints:(JHConstrainMaker)constraints
                              onTap:(JHTapGestureBlock)onTap{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = backColor;
    
    [supView addSubview:view];
    if (supView && constraints) {
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    if (onTap) {
        [view masAddTapGestureWithCallback:onTap];
    }
    
    return view;
    
}


- (UITapGestureRecognizer *)masTapGesture {
    return objc_getAssociatedObject(self, TapGestureKey);
}

- (UILongPressGestureRecognizer *)masLongGesure {
    return objc_getAssociatedObject(self, LongGestureKey);
}

- (void)masAddTapGestureWithCallback:(JHTapGestureBlock)onTaped {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.onTaped = onTaped;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self,
                             TapGestureKey,
                             tap,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)masAddLongGestureWithCallback:(JHLongGestureBlock)onLongPressed {
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] init];
    gesture.onLongPressed = onLongPressed;
    [self addGestureRecognizer:gesture];
    
    objc_setAssociatedObject(self,
                             LongGestureKey,
                             gesture,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
