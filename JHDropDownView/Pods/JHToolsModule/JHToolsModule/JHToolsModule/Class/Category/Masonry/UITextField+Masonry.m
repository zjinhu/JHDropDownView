//
//  UITextField+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UITextField+Masonry.h"
#import "UIView+Frame.h"
#import <objc/runtime.h>
static const void *LeftMarginOfCursorKey = "LeftMarginOfCursor";
@implementation UITextField (Masonry)

- (CGFloat)masLeftMarginOfCursor {
    
    NSNumber *number = objc_getAssociatedObject(self, LeftMarginOfCursorKey);
    
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    
    return 8.0;
}



- (void)setMasLeftMarginOfCursor:(CGFloat)masLeftMarginOfCursor {
    objc_setAssociatedObject(self,
                             LeftMarginOfCursorKey,
                             @(masLeftMarginOfCursor),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.leftView) {
        self.leftView.jh_width = masLeftMarginOfCursor;
    }
}

+ (instancetype)masTextFieldWithHolder:(NSString *)holder
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints {
    return [self masTextFieldWithHolder:holder
                                   text:nil
                              superView:superView
                            constraints:constraints];
}

+ (UITextField *)masTextFieldWithHolder:(NSString *)holder
                                   text:(NSString *)text
                              superView:(UIView *)superView
                            constraints:(JHConstrainMaker)constraints {
    return [self masTextFieldWithHolder:holder
                                   text:text
                               delegate:nil
                              superView:superView
                            constraints:constraints];
}

+ (UITextField *)masTextFieldWithHolder:(NSString *)holder
                               delegate:(id<UITextFieldDelegate>)delegate
                              superView:(UIView *)superView
                            constraints:(JHConstrainMaker)constraints {
    return [self masTextFieldWithHolder:holder
                                   text:nil
                               delegate:delegate
                              superView:superView
                            constraints:constraints];
}

+ (UITextField *)masTextFieldWithHolder:(NSString *)holder
                                   text:(NSString *)text
                               delegate:(id<UITextFieldDelegate>)delegate
                              superView:(UIView *)superView
                            constraints:(JHConstrainMaker)constraints {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.leftView = [[UIView alloc] init];
    textField.leftView.backgroundColor = [UIColor clearColor];
    textField.leftView.jh_width = textField.masLeftMarginOfCursor;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.spellCheckingType = UITextSpellCheckingTypeNo;
    textField.delegate = delegate;
    [superView addSubview:textField];
    
    textField.placeholder = holder;
    textField.text = text;
    
    if (superView && constraints) {
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return textField;
}

@end
