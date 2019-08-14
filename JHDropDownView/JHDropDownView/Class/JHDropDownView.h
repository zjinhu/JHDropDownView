//
//  JHDropDownView.h
//  JHDropDownView
//
//  Created by 张金虎 on 2019/8/14.
//  Copyright © 2019 张金虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JHFrame.h"
NS_ASSUME_NONNULL_BEGIN

@interface JHDropDownView : UIView
+ (instancetype)dropDown;

+ (void)coverTabbar:(UIView *)contentView
              fromY:(CGFloat)fromY
           canClick:(BOOL)canClick
          showBlock:(dispatch_block_t)showBlock
          hideBlock:(dispatch_block_t)hideBlock;

+ (BOOL)hasDropDown;
/**
 隐藏视图
 */
+ (void)hideDropDown;
@end

NS_ASSUME_NONNULL_END
