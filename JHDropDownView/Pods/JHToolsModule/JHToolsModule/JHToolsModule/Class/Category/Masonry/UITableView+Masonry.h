//
//  UITableView+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
@interface UITableView (Masonry)
/**
 *
 *    创建一个表视图，如果superview不是nil，它将被添加约束。它的边将永远等于超级视图。.
 *
 *    @param superView    The super view for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)masTableViewWithSuperview:(UIView *)superView;

/**
 *
 *    创建一个表视图，如果superview是nil，约束将被忽略。.
 *
 *    @param superView        The super view for table view.
 *    @param constraints    Make constraints for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)masTableViewWithSuperview:(UIView *)superView
                              constraints:(JHConstrainMaker)constraints;

/**
 *
 *    创建一个表视图，如果superview不是nil，它将被添加约束。它的边缘将永远等于超级视图。
 *
 *    @param superView    The super view for table view.
 *    @param delegate   Delgate and dataSource.
 *
 *    @return The table view instance.
 */
+ (instancetype)masTableViewWithSuperview:(UIView *)superView delegate:(id)delegate;

/**
 *
 *    创建一个表视图，如果superview是nil，约束将被忽略。
 *
 *    @param superView        The super view for table view.
 *    @param delegate     Delgate and dataSource.
 *    @param constraints    Make constraints for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)masTableViewWithSuperview:(UIView *)superView
                                 delegate:(id)delegate
                              constraints:(JHConstrainMaker)constraints;

/**
 *
 *    创建一个表视图，如果superview是nil，约束将被忽略。可以指定表格视图的风格。
 *
 *    @param superView        The super view for table view.
 *    @param delegate     Delgate and dataSource.
 *    @param style         UITableViewStyle.
 *    @param constraints    Make constraints for table view.
 *
 *    @return The table view instance.
 */
+ (instancetype)masTableViewWithSuperview:(UIView *)superView
                                 delegate:(id)delegate
                                    style:(UITableViewStyle)style
                              constraints:(JHConstrainMaker)constraints;
@end
