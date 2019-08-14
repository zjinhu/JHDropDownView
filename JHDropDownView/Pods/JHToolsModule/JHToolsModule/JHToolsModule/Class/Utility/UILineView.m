//
//  UILineView.m
//  IKToolsModule
//
//  Created by HU on 2018/8/6.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UILineView.h"
#import "JHToolsDefine.h"
#import "BaseUI.h"
@implementation UILineView

- (void)layoutSubviews{
    [super layoutSubviews];
    // 由于设置的是直线或虚线，直接设置背景颜色为透明
    self.backgroundColor = [UIColor clearColor];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    if (width > height){
        CGPathMoveToPoint(path, nil, 0, height / 2.f);
        CGPathAddLineToPoint(path, nil, width, height / 2.f);
    }else{
        CGPathMoveToPoint(path, nil, width / 2.f, 0);
        CGPathAddLineToPoint(path, nil, width / 2.f, height);
    }
    
    CGContextAddPath(context, path);
    
    CGContextSetStrokeColorWithColor(context, self.lineColor ? self.lineColor.CGColor : [UIColor baseLineColor].CGColor);
    CGContextSetLineWidth(context, self.lineWidth == 0 ? LineHeight : self.lineWidth);
    
    if (self.lineType == LineTypeDashLine){
        CGFloat lengths[2] = {self.lineDotWidth == 0 ? 5 : self.lineDotWidth, self.lineDotSpacing == 0 ? 3 : self.lineDotSpacing};
        CGContextSetLineDash(context, self.lineStartPoint == 0 ? 0 : -self.lineStartPoint, lengths, 2);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)setLineType:(BOOL)lineType{
    _lineType = lineType;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setLineStartPoint:(CGFloat)lineStartPoint{
    _lineStartPoint = lineStartPoint;
    [self setNeedsDisplay];
}

- (void)setLineDotWidth:(CGFloat)lineDotWidth{
    _lineDotWidth = lineDotWidth;
    [self setNeedsDisplay];
}

- (void)setLineDotSpacing:(CGFloat)lineDotSpacing{
    _lineDotSpacing = lineDotSpacing;
    [self setNeedsDisplay];
}

@end
