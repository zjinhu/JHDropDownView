//
//  EasyShow.h
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyShowView/EasyShowView.h>

@interface EasyShow : NSObject
//////////toast弹窗
/**
 * 显示一个纯文字消息 （config：显示属性设置，可省略）
 */
+ (void)showText:(NSString *)text ;
+ (void)showText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

/**
 * 显示一个成功消息（config：显示属性设置）
 */
+ (void)showSuccessText:(NSString *)text ;
+ (void)showSuccessText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

/**
 * 显示一个错误消息（config：显示属性设置）
 */
+ (void)showErrorText:(NSString *)text ;
+ (void)showErrorText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

/**
 * 显示一个提示消息（config：显示属性设置）
 */
+ (void)showInfoText:(NSString *)text ;
+ (void)showInfoText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

/**
 * 显示一个自定义图片消息（config：显示属性设置）
 */
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName ;
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName config:(EasyTextConfig *(^)(void))config ;

//////加载loading
/**
 * 显示一个加载框（config：显示属性设置）
 */
+ (void)showLoading ;
+ (void)showLoadingText:(NSString *)text ;
+ (void)showLoadingText:(NSString *)text
                 config:(EasyLoadingConfig *(^)(void))config ;

/**
 * 显示一个带图片的加载框 （config：显示属性设置）
 */
+ (void)showLoadingText:(NSString *)text
              imageName:(NSString *)imageName ;

+ (void)showLoadingText:(NSString *)text
              imageName:(NSString *)imageName
                 config:(EasyLoadingConfig *(^)(void))config ;

/**
 * 移除一个加载框
 * superview:加载框所在的父视图。(如果show没指定父视图。那么隐藏也不用)
 */
+ (void)hidenLoading ;
+ (void)hidenLoingInView:(UIView *)superView ;
+ (void)hidenLoading:(EasyLoadingView *)LoadingView ;


@end
