//
//  EasyShow.m
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "EasyShow.h" 
#import "EasyTextGlobalConfig.h"
#import "EasyTextTypes.h"
#import "EasyLoadingGlobalConfig.h"
#import "EasyAlertGlobalConfig.h"
#import "JHToolsDefine.h"
@implementation EasyShow
+(void)initialize{
//    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //只执行一次就可以了
        EasyTextGlobalConfig *options = [EasyTextGlobalConfig shared];
        //    //在展示消息的时候，界面上是否可以事件。默认为YES，如果你想在展示消息的时候不让用户有手势交互，可设为NO
        options.superReceiveEvent = NO ;
        //显示/隐藏的动画形式。有无动画，渐变，抖动，三种样式。
        options.animationType = TextAnimationTypeFade;
        options.bgColor = UIColorFromName(0x000b16);
        options.titleColor = [UIColor whiteColor];
        options.shadowColor = [UIColor clearColor];
        options.statusType = TextStatusTypeMidden;
        /**显示加载框**/
        EasyLoadingGlobalConfig *lodingConfig = [EasyLoadingGlobalConfig shared];
        lodingConfig.LoadingType = LoadingShowTypeIndicator ;
        
        lodingConfig.bgColor = UIColorFromName(0x000b16);
        lodingConfig.tintColor = [UIColor whiteColor];
        lodingConfig.animationType = LoadingAnimationTypeNone;
        lodingConfig.superReceiveEvent = NO;
        //圆角大小
        lodingConfig.cycleCornerWidth = 8;
    });
}
//////////toast弹窗
/**
 * 显示一个纯文字消息 （config：显示属性设置，可省略）
 */
+ (void)showText:(NSString *)text{
    [EasyTextView showText:text];
}
+ (void)showText:(NSString *)text config:(EasyTextConfig *(^)(void))config{
    [EasyTextView showText:text config:config];
}

/**
 * 显示一个成功消息（config：显示属性设置）
 */
+ (void)showSuccessText:(NSString *)text{
    [EasyTextView showSuccessText:text];
}
+ (void)showSuccessText:(NSString *)text config:(EasyTextConfig *(^)(void))config{
    [EasyTextView showSuccessText:text config:config];
}

/**
 * 显示一个错误消息（config：显示属性设置）
 */
+ (void)showErrorText:(NSString *)text{
    [EasyTextView showErrorText:text];
}
+ (void)showErrorText:(NSString *)text config:(EasyTextConfig *(^)(void))config{
    [EasyTextView showErrorText:text config:config];
}

/**
 * 显示一个提示消息（config：显示属性设置）
 */
+ (void)showInfoText:(NSString *)text{
    [EasyTextView showInfoText:text];
}
+ (void)showInfoText:(NSString *)text config:(EasyTextConfig *(^)(void))config{
    [EasyTextView showInfoText:text config:config];
}

/**
 * 显示一个自定义图片消息（config：显示属性设置）
 */
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName{
    [EasyTextView showImageText:text imageName:imageName];
}
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName config:(EasyTextConfig *(^)(void))config{
    [EasyTextView showImageText:text imageName:imageName config:config];
}

//////加载loading
/**
 * 显示一个加载框（config：显示属性设置）
 */
+ (void)showLoading{
    [EasyLoadingView showLoadingText:@"加载中"];
}
+ (void)showLoadingText:(NSString *)text{
    [EasyLoadingView showLoadingText:text];
}
+ (void)showLoadingText:(NSString *)text
                 config:(EasyLoadingConfig *(^)(void))config{
    [EasyLoadingView showLoadingText:text config:config];
}

/**
 * 显示一个带图片的加载框 （config：显示属性设置）
 */
+ (void)showLoadingText:(NSString *)text
              imageName:(NSString *)imageName{
    [EasyLoadingView showLoadingText:text imageName:imageName];
}

+ (void)showLoadingText:(NSString *)text
              imageName:(NSString *)imageName
                 config:(EasyLoadingConfig *(^)(void))config{
    [EasyLoadingView showLoadingText:text imageName:imageName config:config];
}

/**
 * 移除一个加载框
 * superview:加载框所在的父视图。(如果show没指定父视图。那么隐藏也不用)
 */
+ (void)hidenLoading{
    [EasyLoadingView hidenLoading];
}
+ (void)hidenLoingInView:(UIView *)superView{
    [EasyLoadingView hidenLoingInView:superView];
}
+ (void)hidenLoading:(EasyLoadingView *)LoadingView{
    [EasyLoadingView hidenLoading:LoadingView];
}


@end
