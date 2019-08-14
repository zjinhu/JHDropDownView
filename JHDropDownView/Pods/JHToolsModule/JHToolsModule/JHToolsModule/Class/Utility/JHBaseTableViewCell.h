//
//  JHBaseTableViewCell.h
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/1/22.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseTableViewCell : UITableViewCell

- (void)setUpCellViews;//初始化cell 视图

- (void)setCellWithModel:(id)model;//设置cell model

- (CGFloat)getCellHeightWithModel:(id)model;//设置cell model并拿到cell高度

#pragma mark - register cell tools

+ (void)registerCell:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerCell:(UITableView *)tableView;

+ (instancetype)dequeueReusableCell:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (instancetype)dequeueReusableCell:(UITableView *)tableView;
@end

