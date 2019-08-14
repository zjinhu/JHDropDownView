//
//  UILabel+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UILabel+Masonry.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Masonry)

+(instancetype)masLabelWithFontSize:(CGFloat)fontSize{
    return [self masLabelWithFontSize:fontSize text:nil];
}

+(instancetype)masLabelWithFont:(UIFont *)font{
    return [self masLabelWithFont:font text:nil];
}


+(instancetype)masLabelWithFontSize:(CGFloat)fontSize text:(NSString *)text{
    return [self masLabelWithFontSize:fontSize text:text superView:nil constraints:nil];
}

+(instancetype)masLabelWithFont:(UIFont *)font text:(NSString *)text{
    return [self masLabelWithFont:font text:text superView:nil constraints:nil];
}

+(instancetype)masLabelWithFontSize:(CGFloat)fontSize
                          textColor:(UIColor *)textColor
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints{
    return [self masLabelWithFontSize:fontSize lines:1 text:nil textColor:textColor superView:superView constraints:constraints];
}

+(instancetype)masLabelWithFont:(UIFont *)font
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(JHConstrainMaker)constraints{
    return [self masLabelWithFont:font lines:1 text:nil textColor:textColor superView:superView constraints:constraints];
}


+(instancetype)masLabelWithFontSize:(CGFloat)fontSize
                               text:(NSString *)text
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints{
    return [self masLabelWithFontSize:fontSize lines:1 text:text superView:superView constraints:constraints];
}

+(instancetype)masLabelWithFont:(UIFont *)font
                           text:(NSString *)text
                      superView:(UIView *)superView
                    constraints:(JHConstrainMaker)constraints{
    return [self masLabelWithFont:font lines:1 text:text textColor:nil superView:superView constraints:constraints];
}

+(instancetype)masLabelWithFontSize:(CGFloat)fontSize
                              lines:(NSInteger)lines
                               text:(NSString *)text
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints{
    return [self masLabelWithFontSize:fontSize lines:lines text:text textColor:nil superView:superView constraints:constraints];
}

+(instancetype)masLabelWithFont:(UIFont *)font
                          lines:(NSInteger)lines
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                      superView:(UIView *)superView
                    constraints:(JHConstrainMaker)constraints{
    return [self masInitLabelWithFont:font fontSize:0 lines:lines text:text textColor:textColor superView:superView constraints:constraints];
}

+(instancetype)masLabelWithFontSize:(CGFloat)fontsize
                              lines:(NSInteger)lines
                               text:(NSString *)text
                          textColor:(UIColor *)textColor
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints{
    return [self masInitLabelWithFont:nil fontSize:fontsize lines:lines text:text textColor:textColor superView:superView constraints:constraints];
    
}

+(instancetype)masInitLabelWithFont:(UIFont *)font
                           fontSize:(CGFloat)fontSize
                              lines:(NSInteger)lines
                               text:(NSString *)text
                          textColor:(UIColor *)textColor
                          superView:(UIView *)superView
                        constraints:(JHConstrainMaker)constraints{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    if (fontSize!=0) {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (font != nil) {
        label.font = font;
    }
    
    label.textAlignment = NSTextAlignmentLeft;
    
    // 避免视图混合
    label.backgroundColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    
    if (textColor != nil) {
        label.textColor = textColor;
    }else{
        label.textColor = [UIColor blackColor];
    }
    label.numberOfLines = lines;
    
    /*
     typedef NS_ENUM(NSInteger, NSLineBreakMode) {
     NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
     NSLineBreakByCharWrapping,        // Wrap at character boundaries
     NSLineBreakByClipping,        // Simply clip
     NSLineBreakByTruncatingHead,    // Truncate at head of line: "...wxyz"
     NSLineBreakByTruncatingTail,    // Truncate at tail of line: "abcd..."
     NSLineBreakByTruncatingMiddle    // Truncate middle of line:  "ab...yz"
     } NS_ENUM_AVAILABLE(10_0, 6_0);
     */
    if (lines <= 0) {
        label.lineBreakMode = NSLineBreakByWordWrapping;
    } else {
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    [superView addSubview:label];
    
    if (superView && constraints) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return label;
}


- (void)setColumnSpace:(CGFloat)columnSpace{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

- (void)setRowSpace:(CGFloat)rowSpace{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

+ (CGFloat)getHeightWithText:(NSString*)str width:(CGFloat)width{
    return [self getHeight:str width:width numberOfLines:0];
}

+ (CGFloat)getHeightWithAttribute:(NSMutableAttributedString*)attributedString width:(CGFloat)width{
    return [self getHeight:attributedString width:width numberOfLines:0];
}
+ (CGFloat)getHeight:(id)object width:(CGFloat)width numberOfLines:(NSInteger)numberOfLines{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    label.numberOfLines = numberOfLines;
    if ([object isKindOfClass:[NSString class]]) {
        [label setText:object];
    }else{
        [label setAttributedText:object];
    }
    [label sizeToFit];
    return label.frame.size.height;
}

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}


+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label setText:text lineSpacing:lineSpacing];
    [label sizeToFit];
    return label.frame.size.height;
}

@end
