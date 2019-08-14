//
//  JHBaseTableViewCell.m
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/1/22.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseTableViewCell.h"

@implementation JHBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpCellViews];
    }
    return self;
}

- (void)setUpCellViews{
    //初始化视图
}

- (void)setCellWithModel:(id)model{
    //设置model并更新UI
}

- (CGFloat)getCellHeightWithModel:(id)model{
    [self setCellWithModel:model];
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    //根据masonry撑开的contentView获取cell当前高度,可能用到的地方是缓存高度
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}
#pragma mark - register cell tools

+ (void)registerCell:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerCell:(UITableView *)tableView {
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)dequeueReusableCell:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    return [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
}

+ (instancetype)dequeueReusableCell:(UITableView *)tableView{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
}
@end
