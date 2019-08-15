//
//  JHDropDownView.h
//  JHDropDownView
//
//  Created by 张金虎 on 2019/8/14.
//  Copyright © 2019 张金虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JHFrame.h"

@interface JHDropDownView : UIView
+ (instancetype)dropDown;

//弹出遮罩
+ (void)coverTabbar:(UIView *)contentView       ///需要弹出的菜单视图
              fromY:(CGFloat)fromY              ///菜单弹出的起始坐标
           canClick:(BOOL)canClick              ///是否能点击蒙版收起
          showBlock:(dispatch_block_t)showBlock ///已显示的block
          hideBlock:(dispatch_block_t)hideBlock;///隐藏的block
//判断时候已经存在遮罩
+ (BOOL)hasDropDown;
/**
 隐藏视图
 */
+ (void)hideDropDown;
@end
