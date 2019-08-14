//
//  JHBaseViewController.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseViewController : UIViewController

@property (nonatomic,strong) UIButton        * leftBarButton;               //导航左侧按钮
@property (nonatomic,strong) UIButton        * rightBarButton;              //导航右侧按钮

/**
 *  返回上一级页面
 */
- (void)goBack;
/**
 *  设置导航左侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setLeftBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage;
/**
 *  设置导航右侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setRightBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage;
/**
 *  设置导航左侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 *  @param text           文本
 */
- (void)setLeftBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage AndText:(NSString *)text;

/**
 *  设置导航默认返回按钮
 */
- (void)setLeftBackBarButton;

/**
 *  设置导航左侧按钮文本
 *
 *  @param text 导航按钮文本
 */
- (void)setLeftBarButtonWithText:(NSString *)text;

/**
 *  设置导航右侧按钮文本
 *
 *  @param text 导航按钮文本
 */
- (void)setRightBarButtonWithText:(NSString *)text;
/**
 *  展示toast
 *
 *  @param msg 文本
 */
- (void)showToast:(NSString *)msg;
/**
 *  展示Loading
 
 */
-(void)showLoading;
/**
 *  隐藏Loading
 
 */
-(void)hideLoading;
@end
