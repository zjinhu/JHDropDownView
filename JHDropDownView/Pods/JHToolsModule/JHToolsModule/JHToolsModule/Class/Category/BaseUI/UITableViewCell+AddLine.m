//
//  UITableViewCell+AddLine.m
//  QunQun
//
//  Created by iOS on 2018/1/19.
//  Copyright © 2018年 iOS. All rights reserved.
//
#define MarginLeft          (iPhone_5_5 ? 20 : 16)
#import "UITableViewCell+AddLine.h"
#import "BaseUI.h"
#import "JHToolsDefine.h"
@implementation UITableViewCell (AddLine)
- (void)setFullDownLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight IsNeedSelected:(BOOL)isNeedSelected{
    [self setMarginDownLineWith:tableView IndexPath:indexPath CellHeight:cellHeight Margin:0 IsNeedSelected:isNeedSelected IsAllMargin:NO];
}

- (void)setMarginDownLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsNeedSelected:(BOOL)isNeedSelected IsAllMargin:(BOOL)isAllMargin{
    
    if (cellHeight <= 0) {
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            cellHeight = [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }else{
            cellHeight = CGRectGetHeight(self.bounds);
        }
    }
    
    marign = marign >= 0 ? marign : MarginLeft;
    
    
    UIView * bottomLineView = (UIView *)[self.contentView viewWithTag:BottomLineTag];
    if (!bottomLineView) {
        bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor =[UIColor baseLineColor];
        bottomLineView.tag = BottomLineTag;
        [self.contentView addSubview:bottomLineView];
    }
    
    NSInteger count = 0;
    if ([tableView.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        count = [tableView.dataSource tableView:tableView numberOfRowsInSection:[indexPath section]];
    }
    
    if (isAllMargin) {
        bottomLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - marign, LineHeight);
    }
    else{
        if (indexPath.row == count) {
            bottomLineView.frame = CGRectMake(0, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds), LineHeight);
        }
        else{
            bottomLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - marign, LineHeight);
        }
    }
    
    [self.contentView bringSubviewToFront:bottomLineView];
    
    if (!self.selectedBackgroundView || [NSStringFromClass(self.selectedBackgroundView.class) isEqualToString:@"UITableViewCellSelectedBackground"]) {
        UIView * selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = isNeedSelected ? [UIColor clearColor] : [UIColor cellHighLightColor];
        selectedView.tag = SelectedViewTag;
        self.selectedBackgroundView = selectedView;
    }
    else{
        if (self.selectedBackgroundView.tag == SelectedViewTag) {
            self.selectedBackgroundView.backgroundColor = isNeedSelected ? [UIColor clearColor] : [UIColor cellHighLightColor];
        }
    }
    
    if (isNeedSelected) {
        UIView * selectedLineView = (UIView *)[self.selectedBackgroundView viewWithTag:SelectedLineTag];
        if (!selectedLineView) {
            selectedLineView = [[UIView alloc] init];
            selectedLineView.backgroundColor = [UIColor baseColor];
            selectedLineView.tag = SelectedLineTag;
            [self.selectedBackgroundView addSubview:selectedLineView];
        }
        if (isAllMargin) {
            selectedLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - marign, LineHeight);
        }
        else{
            
            if (indexPath.row == count) {
                selectedLineView.frame = CGRectMake(0, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds), LineHeight);
            }
            else{
                selectedLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - marign, LineHeight);
            }
            
        }
        selectedLineView.hidden = NO;
    }
    else{
        UIView * selectedLineView = (UIView *)[self.selectedBackgroundView viewWithTag:SelectedLineTag];
        selectedLineView.hidden = YES;
    }
    
}


- (void)setFullLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight IsNeedSelected:(BOOL)isNeedSelected{
    [self setMarginLineWith:tableView IndexPath:indexPath CellHeight:cellHeight Margin:0 IsNeedSelected:isNeedSelected];
}


- (void)setMarginLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsNeedSelected:(BOOL)isNeedSelected{
    
    [self setMarginLine:tableView IndexPath:indexPath CellHeight:cellHeight Margin:marign IsNeedSelected:isNeedSelected IsAllMargin:NO IsMidBothMargin:NO];
    
}

- (void)setMidBothMarginHeadAllLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsMidBothMargin:(BOOL)isMidBothMargin{
    
    [self setMarginLine:tableView IndexPath:indexPath CellHeight:cellHeight Margin:marign IsNeedSelected:NO IsAllMargin:NO IsMidBothMargin:isMidBothMargin];
    
}

- (void)setMarginLine:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsNeedSelected:(BOOL)isNeedSelected IsAllMargin:(BOOL)isAllMargin IsMidBothMargin:(BOOL)isMidBothMargin{
    
    if (cellHeight <= 0) {
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            cellHeight = [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }else{
            cellHeight = CGRectGetHeight(self.bounds);
        }
    }
    
    marign = marign >= 0 ? marign : MarginLeft;
    
    UIView * topLineView = (UIView *)[self.contentView viewWithTag:TopLineTag];
    if (!topLineView) {
        topLineView = [[UIView alloc] init];
        topLineView.backgroundColor =[UIColor baseLineColor];
        topLineView.tag = TopLineTag;
        [self.contentView addSubview:topLineView];
    }
    if (indexPath.row == 0) {
        
        if (isAllMargin) {
            topLineView.frame = CGRectMake(marign, 0, CGRectGetWidth(tableView.bounds) - (isMidBothMargin?marign*2:marign), LineHeight);
        }
        else{
            topLineView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), LineHeight);
        }
        topLineView.hidden = NO;
        [self.contentView bringSubviewToFront:topLineView];
    }
    else{
        topLineView.hidden = YES;
    }
    
    UIView * bottomLineView = (UIView *)[self.contentView viewWithTag:BottomLineTag];
    if (!bottomLineView) {
        bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor =[UIColor baseLineColor];
        bottomLineView.tag = BottomLineTag;
        [self.contentView addSubview:bottomLineView];
    }
    
    NSInteger count = 0;
    if ([tableView.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        count = [tableView.dataSource tableView:tableView numberOfRowsInSection:[indexPath section]];
    }
    
    if (isAllMargin) {
        bottomLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - (isMidBothMargin?marign*2:marign), LineHeight);
    }
    else{
        if (indexPath.row == count - 1) {
            bottomLineView.frame = CGRectMake(0, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds), LineHeight);
        }
        else{
            bottomLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - (isMidBothMargin?marign*2:marign), LineHeight);
        }
    }
    
    [self.contentView bringSubviewToFront:bottomLineView];
    
    if (!self.selectedBackgroundView || [NSStringFromClass(self.selectedBackgroundView.class) isEqualToString:@"UITableViewCellSelectedBackground"]) {
        UIView * selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = isNeedSelected ? [UIColor clearColor] : [UIColor cellHighLightColor];
        selectedView.tag = SelectedViewTag;
        self.selectedBackgroundView = selectedView;
    }
    else{
        if (self.selectedBackgroundView.tag == SelectedViewTag) {
            self.selectedBackgroundView.backgroundColor = isNeedSelected ? [UIColor clearColor] : [UIColor cellHighLightColor];
        }
    }
    
    if (isNeedSelected) {
        UIView * selectedLineView = (UIView *)[self.selectedBackgroundView viewWithTag:SelectedLineTag];
        if (!selectedLineView) {
            selectedLineView = [[UIView alloc] init];
            selectedLineView.backgroundColor = [UIColor baseColor];
            selectedLineView.tag = SelectedLineTag;
            [self.selectedBackgroundView addSubview:selectedLineView];
        }
        if (isAllMargin) {
            selectedLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - (isMidBothMargin?marign*2:marign), LineHeight);
        }
        else{
            
            if (indexPath.row == count - 1) {
                selectedLineView.frame = CGRectMake(0, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds), LineHeight);
            }
            else{
                selectedLineView.frame = CGRectMake(marign, cellHeight - LineHeight, CGRectGetWidth(tableView.bounds) - (isMidBothMargin?marign*2:marign), LineHeight);
            }
            
        }
        selectedLineView.hidden = NO;
    }
    else{
        UIView * selectedLineView = (UIView *)[self.selectedBackgroundView viewWithTag:SelectedLineTag];
        selectedLineView.hidden = YES;
    }
    
}

- (void)setMarginMidLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign isBothSideMargin:(BOOL)isBothSideMargin{
    
    if (cellHeight <= 0) {
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            cellHeight = [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }else{
            cellHeight = CGRectGetHeight(self.bounds);
        }
    }
    
    marign = marign >= 0 ? marign : MarginLeft;
    
    UIView * topLineView = (UIView *)[self.contentView viewWithTag:TopLineTag];
    if (!topLineView) {
        topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = [UIColor baseLineColor];
        topLineView.tag = TopLineTag;
        [self.contentView addSubview:topLineView];
    }
    if (indexPath.row == 0) {
        topLineView.hidden = YES;
    }
    else{
        topLineView.frame = CGRectMake(marign, 0,isBothSideMargin?CGRectGetWidth(tableView.bounds)-marign*2 : CGRectGetWidth(tableView.bounds)-marign, LineHeight);
        [self.contentView bringSubviewToFront:topLineView];
        topLineView.hidden = NO;
    }
}
@end
