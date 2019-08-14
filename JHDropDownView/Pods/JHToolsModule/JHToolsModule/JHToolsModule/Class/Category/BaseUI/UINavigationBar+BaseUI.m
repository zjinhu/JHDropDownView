//
//  UINavigationBar+BaseUI.m
//  IKToolsModule
//
//  Created by HU on 2018/7/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UINavigationBar+BaseUI.h"
#import <objc/runtime.h>
@implementation UINavigationBar (BaseUI)
static char overlayKey;

- (UIView *)overlay{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)baseSetBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)baseSetTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)baseSetElementsAlpha:(CGFloat)alpha{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)baseReset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

-(void)hiddenLine{
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = YES;
}
-(void)resetLine{
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = NO;
}
///////以下是导航栏颜色到透明渐变用法
- (void)start {
    
    self.translucent = YES;
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = YES;
}

- (void)reset {
    
    self.translucent = NO;
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = NO;
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)changeColor:(UIColor *)color withOffsetY:(CGFloat)offsetY {
    
    if (offsetY < 0) {
        
        //下拉时导航栏隐藏
        self.hidden = YES;
    }else {
        
        self.hidden = NO;
        //计算透明度，180为随意设置的偏移量临界值
        CGFloat alpha = offsetY / 180 > 1.0f ? 1 : (offsetY / 180);
        
        //设置一个颜色并转化为图片
        UIImage *image = [self imageWithColor:[color colorWithAlphaComponent:alpha]];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        self.translucent = alpha >= 1.0f ? NO : YES;
    }
}

//寻找导航栏下的横线
- (UIImageView *)seekLineImageViewOn:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0){
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        
        UIImageView *imageView = [self seekLineImageViewOn:subview];
        if (imageView){
            return imageView;
        }
    }
    
    return nil;
}

#pragma mark - Color To Image
- (UIImage *)imageWithColor:(UIColor *)color {
    //创建1像素区域并开始图片绘图
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    
    //创建画板并填充颜色和区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    //从画板上获取图片并关闭图片绘图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
