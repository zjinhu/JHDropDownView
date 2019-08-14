//
//  UINavigationBar+BaseUI.h
//  IKToolsModule
//
//  Created by HU on 2018/7/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BaseUI)
- (void)baseSetBackgroundColor:(UIColor *)backgroundColor;
- (void)baseSetElementsAlpha:(CGFloat)alpha;
- (void)baseSetTranslationY:(CGFloat)translationY;
- (void)baseReset;

-(void)hiddenLine;//////隐藏分隔线
-(void)resetLine;//////重置分割线
///////以下是导航栏颜色到透明渐变用法
/**
 *  设置导航栏透明,起点00
 */
- (void)start;

/**
 *  还原导航栏
 */
- (void)reset;
/**
 *  @param color 最终显示颜色
 *  @param offsetY 滑动视图水平偏移量
 */
- (void)changeColor:(UIColor *)color withOffsetY:(CGFloat)offsetY;
@end
