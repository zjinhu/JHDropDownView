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

//弹出遮罩
+ (void)coverTabbar:(UIView *)contentView
              fromY:(CGFloat)fromY
           canClick:(BOOL)canClick
          showBlock:(dispatch_block_t)showBlock
          hideBlock:(dispatch_block_t)hideBlock;
//判断时候已经存在遮罩
+ (BOOL)hasDropDown;
/**
 隐藏视图
 */
+ (void)hideDropDown;
@end

NS_ASSUME_NONNULL_END
