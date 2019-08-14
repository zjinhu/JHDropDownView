//
//  UIGestureRecognizer+Block.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
@interface UIGestureRecognizer (Block)
/**
 *  所有手势都支持Block回调。
 *  支持各种手势。
 */
@property (nonatomic, copy) JHGestureBlock onGesture;

/**
 *
 *    tap手势支持Block回调。
 */
@property (nonatomic, copy) JHTapGestureBlock onTaped;

/**
 *
 *    long手势支持Block回调。
 */
@property (nonatomic, copy) JHLongGestureBlock onLongPressed;
@end
