//
//  UITableViewCell+AddLine.h
//  QunQun
//
//  Created by iOS on 2018/1/19.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TopLineTag          19003
#define BottomLineTag       19004
#define SelectedLineTag     19005
#define SelectedViewTag     19006
@interface UITableViewCell (AddLine)

/**
 *  设置分割线
 *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
 *  @param isNeedSelected 是否需要选中状态
 */
- (void)setFullLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight IsNeedSelected:(BOOL)isNeedSelected;


/**
 *  设置分割线
 *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
 *  @param marign         左侧间距  < 0 时 系统间距   ＝ 0 时 全长
 *  @param isNeedSelected 是否需要选中状态
 */
- (void)setMarginLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsNeedSelected:(BOOL)isNeedSelected;

///**
// *  设置分割线
// *
// *  @param tableView
// *  @param indexPath
// *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
// *  @param marign         左侧间距  < 0 时 系统间距   ＝ 0 时 全长
// *  @param isNeedSelected 是否需要选中状态
// *  @param isAllMargin    是否全部有间隔
// */
//- (void)setMarginLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsNeedSelected:(BOOL)isNeedSelected IsAllMargin:(BOOL)isAllMargin;

/**
 *  设置分割线 只有下边 下边全线

 *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
 *  @param isNeedSelected 是否需要选中状态
 */
- (void)setFullDownLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight IsNeedSelected:(BOOL)isNeedSelected;
/**
 *  设置分割线 只有下边

 *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
 *  @param marign         左侧间距  < 0 时 系统间距   ＝ 0 时 全长
 *  @param isNeedSelected 是否需要选中状态
 *  @param isAllMargin    是否全部有间隔
 */
- (void)setMarginDownLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsNeedSelected:(BOOL)isNeedSelected IsAllMargin:(BOOL)isAllMargin;

/**
 *  设置分割线 只有中间

 *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
 *  @param marign         左侧间距  < 0 时 系统间距   ＝ 0 时 全长
 *  @param isBothSideMargin 是否左右两边都有间距
 */
- (void)setMarginMidLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign isBothSideMargin:(BOOL)isBothSideMargin;
/**
 *  设置分割线 两头全线 中间间距
 *  @param cellHeight     cell的高度 设置《＝0 时 将自动取高度
 *  @param marign         左侧间距  < 0 时 系统间距   ＝ 0 时 全长
 *  @param isMidBothMargin 中间是否左右两边都有间距
 */
- (void)setMidBothMarginHeadAllLineWith:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellHeight:(CGFloat)cellHeight Margin:(CGFloat)marign IsMidBothMargin:(BOOL)isMidBothMargin;
@end
