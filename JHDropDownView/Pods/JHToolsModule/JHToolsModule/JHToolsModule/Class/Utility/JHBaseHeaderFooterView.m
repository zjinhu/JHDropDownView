//
//  JHBaseHeaderFooterView.m
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/1/22.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseHeaderFooterView.h"

@implementation JHBaseHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backColor = [UIColor whiteColor];
        [self setUpViews];
    }
    return self;
}

-(void)setBackColor:(UIColor *)backColor{
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = backColor;
        view;
    });
}

- (void)setUpViews{
    //初始化视图
}

- (void)setWithModel:(id)model{//设置 model
    
}

- (CGFloat)getHeightWithModel:(id)model{//设置 model并拿到高度
    [self setWithModel:model];
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    //根据masonry撑开的contentView获取cell当前高度,可能用到的地方是缓存高度
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

#pragma mark - register cell tools

+ (void)registerHeaderFooterView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}

+ (void)registerHeaderFooterView:(UITableView *)tableView{
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
}

+ (instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView{
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
}

@end
