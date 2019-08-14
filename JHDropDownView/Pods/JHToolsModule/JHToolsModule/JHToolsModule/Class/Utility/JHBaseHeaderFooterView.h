//
//  JHBaseHeaderFooterView.h
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/1/22.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic,strong)UIColor *backColor;//背景颜色

- (void)setUpViews;//初始化视图

- (void)setWithModel:(id)model;//设置 model

- (CGFloat)getHeightWithModel:(id)model;//设置 model并拿到高度

#pragma mark - register cell tools

+ (void)registerHeaderFooterView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerHeaderFooterView:(UITableView *)tableView;

+ (instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView;

@end

