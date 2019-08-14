//
//  UILabel+FitLines.h
//  JHToolsModule
//
//  Created by HU on 2018/9/10.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FitLines)
/**
 最大显示宽度
 */
@property (nonatomic,assign)CGFloat maxWidth;


/**
 行间距
 */
@property (nonatomic,assign)CGFloat lineSpace;


/**
 文本适应于指定的行数
 @return 文本是否被numberOfLines限制
 */
- (BOOL)adjustTextToFitLines:(NSInteger)numberLine;
@end

NS_ASSUME_NONNULL_END
