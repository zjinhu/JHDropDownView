//
//  UIView+Frame.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/**
 * view.center.x
 */
@property CGFloat jh_centerX;
/**
 * view.center.y
 */
@property CGFloat jh_centerY;
/**
 * view.center
 */
@property CGPoint jh_center;
/**
 * view.frame.origin.x
 */
@property CGFloat jh_left;
/**
 * view.frame.size.width + view.frame.origin.x
 */
@property CGFloat jh_right;
/**
 * view.frame.size.height + view.frame.origin.y
 */
@property CGFloat jh_bottom;
/**
 * view.frame.origin.y
 */
@property CGFloat jh_top;
/**
 * view.frame.size.width
 */
@property CGFloat jh_width;
/**
 * view.frame.size.height
 */
@property CGFloat jh_height;
/**
 * view.frame.size
 */
@property CGSize jh_size;

@end
