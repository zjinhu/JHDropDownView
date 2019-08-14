//
//  UIButton+Countdown.m
//  IKToolsModule
//
//  Created by HU on 2018/7/11.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIButton+Countdown.h"

@implementation UIButton (Countdown)

/** 倒计时，s倒计 */
- (void)countdownWithSec:(NSInteger)sec {
    __block NSInteger tempSecond = sec;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (tempSecond <= 1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        } else {
            tempSecond--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:[NSString stringWithFormat:@"%lds", (long)tempSecond] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

/** 倒计时，秒字倒计 */
- (void)countdownWithSecond:(NSInteger)second {
    __block NSInteger tempSecond = second;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (tempSecond <= 1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        } else {
            tempSecond--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:[NSString stringWithFormat:@"%ld秒", (long)tempSecond] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

/** 倒计时，s倒计,带有回调 */
- (void)countdownWithSec:(NSInteger)sec completion:(CountdownCompletionBlock)block {
    __block NSInteger tempSecond = sec;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (tempSecond <= 1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                block();
            });
        } else {
            tempSecond--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:[NSString stringWithFormat:@"%lds", (long)tempSecond] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

/** 倒计时,秒字倒计，带有回调 */
- (void)countdownWithSecond:(NSInteger)second completion:(CountdownCompletionBlock)block {
    __block NSInteger tempSecond = second;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (tempSecond <= 1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                block();
            });
        } else {
            tempSecond--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:[NSString stringWithFormat:@"%ld秒", (long)tempSecond] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

@end
