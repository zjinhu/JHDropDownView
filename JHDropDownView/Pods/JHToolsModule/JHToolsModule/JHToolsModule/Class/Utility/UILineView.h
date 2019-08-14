//
//  UILineView.h
//  IKToolsModule
//
//  Created by HU on 2018/8/6.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LineType) {
    LineTypeStraightLine,
    LineTypeDashLine
};
@interface UILineView : UIView
// 如果不指定 lineType，默认绘制实线，否则为虚线
@property (nonatomic, assign) BOOL lineType;

/**
 线条宽度 lineWidth 默认 1
 线条颜色 lineColor 默认 blackColor
从第几个像素开始画 lineStartPoint 默认 0
虚线点的宽度 lineDotWidth 默认 5
虚线点之间的间距 lineDotSpacing 默认 3
 
 当视图宽大于高，水平虚线
 当视图高大于宽，竖直虚线
 当视图宽高相等，竖直虚线
 */
@property (nonatomic, assign) CGFloat  lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat  lineStartPoint;
@property (nonatomic, assign) CGFloat  lineDotWidth;
@property (nonatomic, assign) CGFloat  lineDotSpacing;
 
@end
