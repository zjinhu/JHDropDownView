//
//  JHMasonryTool.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
@interface JHMasonryTool : NSObject
/**
 * Button点击事件Block
 *
 */
typedef void(^JHButtonBlock)(id sender);
/**
 * gesture事件Block
 *
 */
typedef void(^JHGestureBlock)(UIGestureRecognizer *gesture);


/**
 * Tap点击事件Block
 *
 */
typedef void(^JHTapGestureBlock)(UITapGestureRecognizer *gesture);

/**
 * Tap长按事件Block
 *
 */
typedef void(^JHLongGestureBlock)(UILongPressGestureRecognizer *gesture);

/**
 * Masonry Block
 *
 */
typedef void(^JHConstrainMaker)(MASConstraintMaker *make);
@end
