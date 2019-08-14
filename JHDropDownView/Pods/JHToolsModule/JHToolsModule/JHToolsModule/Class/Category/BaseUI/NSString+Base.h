//
//  NSString+Base.h
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Base)
- (NSString *)getMD5;
- (NSString *)stringByTrim;
- (NSString *)getBase64;

- (BOOL)empty;
- (BOOL)isNotNull;
- (BOOL)isTelephone;
- (BOOL)isIdentifyNo;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)getSizeWithFont:(UIFont *)font;

- (CGSize)getSizeWithAtt:(NSDictionary *)att ConstrainedToSize:(CGSize)size;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size AndLineHeight:(CGFloat)lineHeight;



//单行的
- (CGSize)textSizeWithFont:(UIFont*)font;
/**
 根据字体、行数、行间距和constrainedWidth计算多行文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth
          isLimitedToLines:(BOOL *)isLimitedToLines;
@end
