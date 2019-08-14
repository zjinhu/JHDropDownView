//
//  UIView+JHFrame.m
//  JHDropDownView
//
//  Created by 张金虎 on 2019/8/14.
//  Copyright © 2019 张金虎. All rights reserved.
//

#import "UIView+JHFrame.h"

@implementation UIView (JHFrame)

- (void)setJh_center:(CGPoint)jh_center {
    self.center = jh_center;
}

- (CGPoint)jh_center {
    return self.center;
}

- (void)setJh_centerX:(CGFloat)jh_centerX {
    CGPoint center = self.center;
    center.x = jh_centerX;
    self.center = center;
}

- (CGFloat)jh_centerX {
    return self.center.x;
}

- (void)setJh_centerY:(CGFloat)jh_centerY {
    CGPoint center = self.center;
    center.y = jh_centerY;
    self.center = center;
}

- (CGFloat)jh_centerY {
    return self.center.y;
}

- (void)setJh_size:(CGSize)jh_size {
    CGRect rect = self.frame;
    rect.size = jh_size;
    self.frame = rect;
}

- (CGSize)jh_size {
    return self.frame.size;
}

- (void)setJh_width:(CGFloat)jh_width {
    CGRect rect = self.frame;
    rect.size.width = jh_width;
    self.frame = rect;
}

- (CGFloat)jh_width {
    return self.frame.size.width;
}

- (void)setJh_height:(CGFloat)jh_height {
    CGRect rect = self.frame;
    rect.size.height = jh_height;
    self.frame = rect;
}

- (void)setJh_right:(CGFloat)jh_right{
    CGRect rect = self.frame;
    rect.origin.x = jh_right - rect.size.width;
    self.frame = rect;
}
- (void)setJh_left:(CGFloat)jh_left{
    CGRect rect = self.frame;
    rect.origin.x = jh_left;
    self.frame = rect;
}
- (CGFloat)jh_left{
    return self.frame.origin.x;
}
- (CGFloat)jh_right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setJh_bottom:(CGFloat)jh_bottom{
    CGRect rect = self.frame;
    rect.origin.y = jh_bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)jh_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setJh_top:(CGFloat)jh_top{
    CGRect rect = self.frame;
    rect.origin.y = jh_top;
    self.frame = rect;
}

- (CGFloat)jh_top{
    return self.frame.origin.y;
}


- (CGFloat)jh_height {
    return self.frame.size.height;
}
@end
