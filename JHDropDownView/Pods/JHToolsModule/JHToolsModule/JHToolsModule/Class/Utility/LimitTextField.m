//
//  IKTextField.m
//  IKToolsModule
//
//  Created by 狄烨 . on 2018/12/20.
//  Copyright © 2018 HU. All rights reserved.
//

#import "LimitTextField.h"
@interface LimitTextField ()<UITextFieldDelegate>

@end
@implementation LimitTextField

// 写在这里为了兼容代码创建和xib创建
- (void)drawRect:(CGRect)rect {
    [self addTarget:self action:@selector(textFieldTextEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.delegate = self;
}

- (void)textFieldTextEditingChanged:(id)sender {
    if (self.limitLength == 0) {
        return;
    }
    if (self.textFieldTextEditingChangedBlock) {
        self.textFieldTextEditingChangedBlock(sender);
    }
    UITextField *textField = (UITextField *)sender;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > self.limitLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.limitLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:self.limitLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.limitLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.textFieldShouldBeginEditingBlock) {
        return self.textFieldShouldBeginEditingBlock(textField);
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.textFieldDidBeginEditingBlock) {
        self.textFieldDidBeginEditingBlock(textField);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.textFieldShouldEndEditingBlock) {
        return self.textFieldShouldEndEditingBlock(textField);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFieldDidEndEditingBlock) {
        self.textFieldDidEndEditingBlock(textField);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.textFieldShouldReturnBlock) {
        return self.textFieldShouldReturnBlock(textField);
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.textFieldShouldChangeCharactersInRangeReplacementStringBlock) {
        return self.textFieldShouldChangeCharactersInRangeReplacementStringBlock(textField, range, string);
    }
    return YES;
}

@end
