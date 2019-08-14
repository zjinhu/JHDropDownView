//
//  UILabel+FitLines.m
//  JHToolsModule
//
//  Created by HU on 2018/9/10.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UILabel+FitLines.h"
#import "NSString+Base.h"
#import <objc/runtime.h>
@implementation UILabel (FitLines)

/**
 行间距
 */
- (void)setLineSpace:(CGFloat)lineSpace{
    
    objc_setAssociatedObject(self, @selector(lineSpace), [NSNumber numberWithFloat:lineSpace], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lineSpace{
    
    return [objc_getAssociatedObject(self, @selector(lineSpace)) floatValue];
}

/**
 最大显示宽度
 */
- (void)setMaxWidth:(CGFloat)maxWidth{
    
    objc_setAssociatedObject(self, @selector(maxWidth), [NSNumber numberWithFloat:maxWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)maxWidth{
    
    return [objc_getAssociatedObject(self, @selector(maxWidth)) floatValue];
}

/**
 文本适应于指定的行数
 @return 文本是否被numberOfLines限制
 */
- (BOOL)adjustTextToFitLines:(NSInteger)numberLine{
    
    if (!self.text || self.text.length == 0) {
        return NO;
    }
    
    self.numberOfLines = numberLine;
    BOOL isLimitedToLines = NO;
    
    CGSize textSize = [self.text textSizeWithFont:self.font numberOfLines:self.numberOfLines lineSpacing:self.lineSpace constrainedWidth:self.maxWidth isLimitedToLines:&isLimitedToLines];
    
    //单行的情况
    if (fabs(textSize.height - self.font.lineHeight) < 0.00001f) {
        self.lineSpace = 0.0f;
    }
    
    //设置文字的属性
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.lineSpace];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [self.text length])];
    
    
    [self setAttributedText:attributedString];
    self.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    return isLimitedToLines;
}

@end
