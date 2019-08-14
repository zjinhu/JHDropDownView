//
//  JHBaseTableViewController.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//


#import "JHBaseViewController.h"
typedef NS_ENUM(NSInteger,TableViewType) {
    TableViewStylePlain = 0,
    TableViewStyleGrouped
};
@interface JHBaseTableViewController : JHBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * mainDataArr;
@property (nonatomic, assign) TableViewType tableViewType;

/**
 *  不延时响应按钮的点击事件  默认延时
 */
@property (nonatomic,assign) BOOL unDelaysContentTouches;

/**
 *  设置列表属性
 */
- (void)setTableViewStyleGrouped;

/**
 *  初始化
 */
- (void)initData;

/**
 *  加载更多回调函数
 */
- (void)loadMoreData;

/**
 *  下拉刷新回调函数
 */
- (void)refreshData;

/**
 *  停止刷新
 */
- (void)endTableViewRefreshing;

/**
 *  隐藏显示上下拉加载
 */
-(void)showRefreshHeader;
-(void)hiddenRefreshHeader;
-(void)showRefreshFooter;
-(void)hiddenRefreshFooter;
@end
