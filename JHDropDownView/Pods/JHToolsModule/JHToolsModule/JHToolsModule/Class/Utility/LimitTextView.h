//
//  IKTextView.h
//  IKToolsModule
//
//  Created by 狄烨 . on 2018/12/20.
//  Copyright © 2018 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 欲用此控件就不能设置代理，用block代替
 */
@interface LimitTextView : UITextView
@property (nonatomic, assign) NSInteger limitLength;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UILabel *textNumLabel;

#pragma mark - UITextViewDelegate

@property (nonatomic, copy) void (^textViewDidChangeBlock)(UITextView *textView);
@property (nonatomic, copy) BOOL (^textViewShouldBeginEditingBlock)(UITextView *textView);
@property (nonatomic, copy) BOOL (^textViewShouldEndEditingBlock)(UITextView *textView);
@property (nonatomic, copy) void (^textViewDidBeginEditingBlock)(UITextView *textView);
@property (nonatomic, copy) void (^textViewDidEndEditingBlock)(UITextView *textView);
@property (nonatomic, copy) BOOL (^textViewShouldChangeTextInRangeReplacementTextBlock)(UITextView *textView, NSRange range, NSString *text);
@end
