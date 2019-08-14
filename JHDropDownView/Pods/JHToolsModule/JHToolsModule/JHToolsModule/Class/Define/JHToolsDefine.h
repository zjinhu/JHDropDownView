//
//  JHToolsDefine.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#ifndef JHToolsDefine_h
#define JHToolsDefine_h

#import <Masonry/Masonry.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

static const CGFloat d5 = 5.0f;
static const CGFloat d10 = 10.0f;
static const CGFloat d15 = 15.0f;
static const CGFloat d20 = 20.0f;
static const CGFloat d30 = 30.0f;

static const CGFloat w10 = 10.0f;
static const CGFloat w20 = 20.0f;
static const CGFloat w30 = 30.0f;
static const CGFloat w40 = 40.0f;
static const CGFloat w50 = 50.0f;
static const CGFloat w60 = 60.0f;

static const CGFloat h10 = 10.0f;
static const CGFloat h20 = 20.0f;
static const CGFloat h30 = 30.0f;
static const CGFloat h40 = 40.0f;
static const CGFloat h50 = 50.0f;
static const CGFloat h60 = 60.0f;

static const CGFloat h44 = 44.0f;
static const CGFloat h64 = 64.0f;
//weak
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
////可以对非self参数进行weak
//#define weakify(var) __weak typeof(var) weak##var = var;
//#define strongify(var) \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Wshadow\"") \
//__strong typeof(var) var = weak##var; \
//_Pragma("clang diagnostic pop")

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

////////////////////////////////////////////////////////////////
//图片
#define ImageNamed(NAME)  ([UIImage imageNamed:NAME])
//比例线
#define Scare       [[UIScreen mainScreen] scale]
#define LineHeight  (Scare >= 1 ? 1/Scare : 1)
//字体
#define FontOfMedium(sizeint)   [UIFont systemFontOfSize:sizeint weight:UIFontWeightMedium]
#define FontOfSemibold(sizeint) [UIFont systemFontOfSize:sizeint weight:UIFontWeightSemibold]
#define Font(sizeint)           [UIFont systemFontOfSize:sizeint]
//FontOfWidgt(16, UIFontWeightMedium);
#define FontOfWidgt(sizeint,w)          [UIFont systemFontOfSize:sizeint weight:w]
#define RealValue(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)///仅用于字体,view大小用#define FIT_WIDTH  (SCREEN_WIDTH/375) FIT_HEIGHT  (SCREEN_HEIGHT/667)

///颜色
#define CLEARCOLOR [UIColor clearColor]

#define UIColorFromName(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define ColorOfRandom random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 判断是否是iPhone X
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define iPhone_3_5  (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)  //3.5寸
#define iPhone_4    (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0) //4寸
#define iPhone_4_7  (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0) //4.7寸
#define iPhone_5_5  (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0) //5.5寸
#define iPhoneX     (IS_IPHONE && SCREEN_MAX_LENGTH >= 812)  //iPhoneX刘海系列
#define iPhone_5_8  (IS_IPHONE && SCREEN_MAX_LENGTH == 812)  //5.8寸
#define iPhone_6_1  (IS_IPHONE && SCREEN_MAX_LENGTH == 896 && Scare==2.0)  //6.1寸
#define iPhone_6_5  (IS_IPHONE && SCREEN_MAX_LENGTH == 896 && Scare==3.0)  //6.5寸

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)

#define NAVIGATION_BAR_HEIGHT_NORMAL (iPhoneX ? 68.f : 44.f)

// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

//屏幕尺寸
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define FIT_WIDTH  (SCREEN_WIDTH/375)
#define FIT_HEIGHT  (SCREEN_HEIGHT/667)
//APP BundleID
#define kBundleID [[NSBundle mainBundle] bundleIdentifier]
//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IOS10_OR_BEFORE ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IOS12_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)
//单例封装(用法.h SingletonH; .m SingletonM(A);  类: [A shared])
// .h
#define SingletonH  + (instancetype)shared ;
// .m
#define SingletonM(class) \
static class *_showInstance; \
+ (id)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_showInstance = [super allocWithZone:zone]; \
}); \
return _showInstance; \
} \
+ (instancetype)shared { \
if (nil == _showInstance) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_showInstance = [[class alloc] init]; \
}); \
} \
return _showInstance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _showInstance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone{ \
return _showInstance; \
} \

///LOG
#ifdef DEBUG
#define NSLog(format, ...) printf("\n\n↓↓↓↓↓↓↓↓↓↓↓↓[Log]↓↓↓↓↓↓↓↓↓↓↓↓\n>>>>>>>>>>>>>位置<<<<<<<<<<<<<\n%s\n>>>>>>>>>>>>>方法<<<<<<<<<<<<<\n%s\n>>>>>>>>>>>>>行数<<<<<<<<<<<<<\n第%d行\n>>>>>>>>>>>>>信息<<<<<<<<<<<<<\n%s\n↑↑↑↑↑↑↑↑↑↑↑↑[END]↑↑↑↑↑↑↑↑↑↑↑↑\n\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(...)
#endif
#endif /* JHToolsDefine_h */
