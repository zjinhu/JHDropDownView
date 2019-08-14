//
//  JHBaseTableView.h
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/6/13.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface JHBaseTableView : UITableView
typedef UITableViewCell *_Nonnull(^SetCellAtIndexPath)(NSIndexPath * _Nonnull indexPath,UITableView *tableView);
typedef CGFloat (^SetCellHeightAtIndexPath)(NSIndexPath *indexPath);
typedef CGFloat (^SetCountOfSectionsInTableView)(UITableView *tableView);
typedef CGFloat (^SetCountOfRowsInSection)(NSUInteger section);
typedef UIView *_Nonnull(^SetHeaderViewInSection)(NSInteger section);
typedef UIView *_Nonnull(^SetFooterViewInSection)(NSInteger section);
typedef CGFloat (^SetHeaderHeightInSection)(NSInteger section);
typedef CGFloat (^SetFooterHeightInSection)(NSInteger section);

typedef void (^GetCellAtIndexPath)(NSIndexPath *indexPath,UITableViewCell *cell);
typedef void (^GetHeaderViewInSection)(NSUInteger section,UIView *headerView,NSMutableArray *secArr);
typedef void (^GetFooterViewInSection)(NSUInteger section,UIView *footerView,NSMutableArray *secArr);
#pragma mark - 数据设置
///设置所有数据数组
@property(nonatomic, strong)NSMutableArray *mainDataArr;
///系统Cell自动高度 默认为NO
@property(nonatomic, assign)BOOL cellAutomaticDimension;
///系统HeaderView自动高度，默认为NO
@property(nonatomic, assign)BOOL headerAutomaticDimension;
///系统FooterView自动高度，默认为NO
@property(nonatomic, assign)BOOL footerAutomaticDimension;
///无数据是否显示HeaderView，默认为YES
@property(nonatomic, assign)BOOL showHeaderWhenNoData;
///无数据是否显示FooterView，默认为YES
@property(nonatomic, assign)BOOL showFooterWhenNoData;
#pragma mark - Block
///声明cell的类 需要先注册cell
@property (nonatomic, copy) SetCellAtIndexPath setCellAtIndexPath;
///设置cell的高度(非必须，若设置了，则内部的自动计算高度无效)
@property (nonatomic, copy) SetCellHeightAtIndexPath setCellHeightAtIndexPath;
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property (nonatomic, copy) SetCountOfSectionsInTableView setCountOfSectionsInTableView;
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property (nonatomic, copy) SetCountOfRowsInSection setCountOfRowsInSection;
///设置HeaderView，必须实现zx_setHeaderHInSection
@property (nonatomic, copy) SetHeaderViewInSection setHeaderViewInSection;
///设置FooterView，必须实现zx_setFooterHInSection
@property (nonatomic, copy) SetFooterViewInSection setFooterViewInSection;
///设置HeaderView高度，非必须，若设置了则自动设置的HeaderView高度无效
@property (nonatomic, copy) SetHeaderHeightInSection setHeaderHeightInSection;
///设置FooterView高度，非必须，若设置了则自动设置的FooterView高度无效
@property (nonatomic, copy) SetFooterHeightInSection setFooterHeightInSection;

///获取对应行的cell，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) GetCellAtIndexPath getCellAtIndexPath;
///获取对应section的headerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property (nonatomic, copy) GetHeaderViewInSection getHeaderViewInSection;
///获取对应section的footerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property (nonatomic, copy) GetFooterViewInSection getFooterViewInSection;
#pragma mark - 快速构建
///声明cell的类并返回cell对象
-(void)setCellAtIndexPath:(SetCellAtIndexPath)setCellCallBack returnCell:(GetCellAtIndexPath)returnCellCallBack;
///声明HeaderView的类并返回HeaderView对象
-(void)setHeaderViewInSection:(SetHeaderViewInSection)setHeaderViewCallBack returnHeader:(GetHeaderViewInSection)returnHeaderCallBack;
///声明FooterView的类并返回FooterView对象
-(void)setFooterViewInSection:(SetFooterViewInSection)setFooterViewCallBack returnHeader:(GetFooterViewInSection)returnFooterCallBack;
#pragma mark - 代理事件相关
///选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^didSelectedAtIndexPath)(NSIndexPath *indexPath,id cell);
///取消选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^didDeselectedAtIndexPath)(NSIndexPath *indexPath,id cell);
///滑动编辑
@property (nonatomic, copy) NSArray<UITableViewRowAction *>* (^editActionsForRowAtIndexPath)(NSIndexPath *indexPath);
///cell将要展示，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^willDisplayCell)(NSIndexPath *indexPath,id cell);
///scrollView滚动事件
@property (nonatomic, copy) void (^scrollViewDidScroll)(UIScrollView *scrollView);
///scrollView缩放事件
@property (nonatomic, copy) void (^scrollViewDidZoom)(UIScrollView *scrollView);
///scrollView滚动到顶部事件
@property (nonatomic, copy) void (^scrollViewDidScrollToTop)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^scrollViewWillBeginDragging)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL willDecelerate);
#pragma mark - UITableViewDataSource & UITableViewDelegate
///tableView的DataSource 设置为当前控制器即可重写对应数据源方法
@property (nonatomic, weak, nullable) id <UITableViewDataSource> tableDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property (nonatomic, weak, nullable) id <UITableViewDelegate> tableDelegate;
@end
NS_ASSUME_NONNULL_END
