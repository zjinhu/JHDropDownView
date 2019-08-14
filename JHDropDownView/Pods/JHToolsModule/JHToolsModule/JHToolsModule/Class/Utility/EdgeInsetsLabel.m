//
//  EdgeInsetsLabel.m
//  JHToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "EdgeInsetsLabel.h"

#import <objc/runtime.h>
@implementation EdgeInsetsLabel
- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    NSString *tempString = self.text;
    self.text = @"";
    self.text = tempString;
}

- (void)setAlignment:(EdgeInsetsLabelTextAlignment)alignment
{
    objc_setAssociatedObject(self, @selector(alignment), @(alignment), OBJC_ASSOCIATION_RETAIN);
}

- (EdgeInsetsLabelTextAlignment)alignment
{
    return [objc_getAssociatedObject(self, @selector(alignment)) intValue];
}


- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    if (self.alignment == EdgeInsetsLabelTextAlignment_Top) {
        textRect.origin.y = bounds.origin.y;
    }else if(self.alignment == EdgeInsetsLabelTextAlignment_Down){
        textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
    }else{
        
    }
    
    return textRect;
    
}


-(void)drawTextInRect:(CGRect)rect {
    if (self.alignment == EdgeInsetsLabelTextAlignment_Top || self.alignment == EdgeInsetsLabelTextAlignment_Down) {
        CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
        [super drawTextInRect:UIEdgeInsetsInsetRect(actualRect, self.contentInset)];
    }else{
        [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInset)];
    }
}

@end
