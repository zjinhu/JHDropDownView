//
//  UILabel+AttributeClick.h
//  IKToolsModule
//
//  Created by 狄烨 . on 2018/11/28.
//  Copyright © 2018 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AttributeClick)
#pragma mark - #######富文本#########
/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL supportClick;

/**
 *  点击高亮色 默认是[UIColor lightGrayColor] 需打开enableClick才有效
 */
@property (nonatomic, strong) UIColor * highLightColor;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param clickBlock 点击事件回调
 */
- (void)addAttributeClickWithStrings:(NSArray <NSString *> *)strings
                              clickBlock:(void (^) (NSString *string,NSInteger index))clickBlock;

/**
 *  根据range给文本添加点击事件Block回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param clickBlock 点击事件回调
 */
- (void)addAttributeClickWithRanges:(NSArray <NSString *> *)ranges
                             clickBlock:(void (^) (NSString *string,NSInteger index))clickBlock;
/**
 *  设置显示的富文本
 *
 *  @param sender  可以是Range数组/字符串数组/单纯的一个字符串
 *  @param string 需要显示的完整字符串
 *  @param normalFont  普通字体
 *  @param normalColor 普通字体颜色
 *  @param attributeFont  需要点击的字体
 *  @param attributeColor 需要点击的字体颜色
 */
- (void)setAttributeWith:(id)sender
                  string:(NSString *)string
              normalFont:(UIFont *)normalFont
             normalColor:(UIColor *)normalColor
           attributeFont:(UIFont *)attributeFont
          attributeColor:(UIColor *)attributeColor;
@end

NS_ASSUME_NONNULL_END
