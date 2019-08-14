//
//  UITableView+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UITableView+Masonry.h"

@implementation UITableView (Masonry)
+ (instancetype)masTableViewWithSuperview:(UIView *)superView {
    return [self masTableViewWithSuperview:superView delegate:nil];
}

+ (instancetype)masTableViewWithSuperview:(UIView *)superView
                              constraints:(JHConstrainMaker)constraints {
    return [self masTableViewWithSuperview:superView delegate:nil constraints:constraints];
}

+ (instancetype)masTableViewWithSuperview:(UIView *)superView delegate:(id)delegate {
    return [self masTableViewWithSuperview:superView
                                  delegate:delegate
                               constraints:^(MASConstraintMaker *make) {
                                   if (superView) {
                                       make.edges.mas_equalTo(superView);
                                   }
                               }];
}

+ (instancetype)masTableViewWithSuperview:(UIView *)superView
                                 delegate:(id)delegate
                              constraints:(JHConstrainMaker)constraints {
    return [self masTableViewWithSuperview:superView
                                  delegate:delegate
                                     style:UITableViewStylePlain
                               constraints:constraints];
}

+ (instancetype)masTableViewWithSuperview:(UIView *)superView
                                 delegate:(id)delegate
                                    style:(UITableViewStyle)style
                              constraints:(JHConstrainMaker)constraints {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [UIView new];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.estimatedRowHeight = 100;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.delaysContentTouches = YES;
    if (@available(iOS 11.0, *)){
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    [superView addSubview:tableView];
    
    if (superView && constraints) {
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return tableView;
}
@end
