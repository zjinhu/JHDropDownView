//
//  UIButton+Countdown.h
//  IKToolsModule
//
//  Created by HU on 2018/7/11.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CountdownCompletionBlock)(void);
@interface UIButton (Countdown)
/** 倒计时，s倒计 */
- (void)countdownWithSec:(NSInteger)time;
/** 倒计时，秒字倒计 */
- (void)countdownWithSecond:(NSInteger)second;
/** 倒计时，s倒计,带有回调 */
- (void)countdownWithSec:(NSInteger)sec completion:(CountdownCompletionBlock)block;
/** 倒计时,秒字倒计，带有回调 */
- (void)countdownWithSecond:(NSInteger)second completion:(CountdownCompletionBlock)block;
@end

NS_ASSUME_NONNULL_END
