//
//  JHBaseTableViewController.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "JHToolsDefine.h"
#import "BaseUI.h"
#import <MJRefresh/MJRefresh.h>
#import "Utility.h" 
@interface JHBaseTableViewController ()

@end

@implementation JHBaseTableViewController

- (void)setTableViewStyleGrouped{
//    self.tableViewType = TableViewStyleGrouped;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  初始化
     */
    [self initData];
    [self setTableViewStyleGrouped];
    if (_tableViewType == TableViewStylePlain) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
    }
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor baseLineColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    //头角需要自适应高度的话请设置
//    self.tableView.estimatedSectionHeaderHeight = 200;
//    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedSectionFooterHeight = 200;
//    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    _tableView.delaysContentTouches = YES;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }];
    }else{
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    __weak typeof (self) weakSelf = self;
    /**
     *  添加上拉刷新
     */
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    
    /**
     *  添加下拉加载
     */
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    /**
     *  初始隐藏
     */
    _tableView.mj_header.hidden = YES;
    _tableView.mj_footer.hidden = YES;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    if (@available(iOS 11.0, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;//获取所有的手势
    //当是侧滑手势的时候设置panGestureRecognizer需要UIScreenEdgePanGestureRecognizer失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [_tableView.panGestureRecognizer requireGestureRecognizerToFail:gesture];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mainDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
#pragma mark 事件

/**
 *  初始化
 */
- (void)initData{
    //    [self showLoadingView];
    _mainDataArr = [NSMutableArray array];
}

/**
 *  加载更多回调函数
 */
- (void)loadMoreData{
    
}
/**
 *  下拉刷新回调函数
 */

- (void)refreshData{
    
}

- (void)endTableViewRefreshing{
    [_tableView.mj_footer endRefreshing];
    [_tableView.mj_header endRefreshing];
}

- (void)setUnDelaysContentTouches:(BOOL)unDelaysContentTouches{
    
    _tableView.delaysContentTouches = unDelaysContentTouches;
    _unDelaysContentTouches = unDelaysContentTouches;
}
#pragma mark 下拉刷新
-(void)showRefreshHeader{
    _tableView.mj_header.hidden = NO;
}
-(void)hiddenRefreshHeader{
    _tableView.mj_header.hidden = YES;
}

-(void)hiddenRefreshFooter{
    _tableView.mj_footer.hidden = YES;
}
-(void)showRefreshFooter{
    _tableView.mj_footer.hidden = NO;
}
@end
