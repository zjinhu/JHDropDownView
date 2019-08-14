//
//  JHToolsModule.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#ifndef JHToolsModule_h
#define JHToolsModule_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#if __has_include(<JHToolsModule/JHToolsModule.h>)

#import <JHToolsModule/JHToolsDefine.h>
#import <JHToolsModule/EasyShow.h>
#import <JHToolsModule/Utility.h>
#import <JHToolsModule/BaseVC.h>
#import <JHToolsModule/Category.h>

#else

#import "BaseVC.h"
#import "EasyShow.h"
#import "JHToolsDefine.h"
#import "Category.h"
#import "Utility.h"
#endif


#endif /* JHToolsModule_h */
