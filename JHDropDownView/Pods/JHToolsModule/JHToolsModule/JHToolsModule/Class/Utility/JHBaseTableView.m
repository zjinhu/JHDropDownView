//
//  JHBaseTableView.m
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/6/13.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseTableView.h"
@interface JHBaseTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation JHBaseTableView

-(instancetype)init{
    if (self = [super init]) {
        [self setupTableView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        [self setupTableView];
    }
    return self;
}

-(void)setupTableView{
    self.mainDataArr = [NSMutableArray array];
    self.delegate = self;
    self.dataSource = self;
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.delaysContentTouches = YES;
}

-(void)setMainDataArr:(NSMutableArray *)mainDataArr{
    _mainDataArr = mainDataArr;
    if(mainDataArr){
        NSAssert([mainDataArr isKindOfClass:[NSArray class]], @"mainDataArr必须为数组");
    }
    [self reloadData];
}

-(void)setCellAutomaticDimension:(BOOL)cellAutomaticDimension{
    _cellAutomaticDimension = cellAutomaticDimension;
    if(_cellAutomaticDimension){
        self.estimatedRowHeight = 60;
        self.rowHeight = UITableViewAutomaticDimension;
    }
}

-(void)setHeaderAutomaticDimension:(BOOL)headerAutomaticDimension{
    _headerAutomaticDimension = headerAutomaticDimension;
    if(_headerAutomaticDimension){
        self.estimatedSectionHeaderHeight = 60;
        self.sectionHeaderHeight = UITableViewAutomaticDimension;
    }
}
-(void)setFooterAutomaticDimension:(BOOL)footerAutomaticDimension{
    _footerAutomaticDimension = footerAutomaticDimension;
    if(_footerAutomaticDimension){
        self.estimatedSectionFooterHeight = 60;
        self.sectionFooterHeight = UITableViewAutomaticDimension;
    }
}
#pragma mark 判断是否是多个section的情况
-(BOOL)isMultiDatas{
    return self.mainDataArr.count && [self.mainDataArr.firstObject isKindOfClass:[NSArray class]];
}

#pragma mark - UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if([self.tableDataSource respondsToSelector:@selector(cellForRowAtIndexPath:)]){
        return [self.tableDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }else{
        UITableViewCell *cell = nil;
        if(self.setCellAtIndexPath){
            cell =self.setCellAtIndexPath(indexPath,tableView);
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
            }
        }
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.tableDataSource respondsToSelector:@selector(numberOfRowsInSection:)]){
        return [self.tableDataSource tableView:tableView numberOfRowsInSection:section];
    }else{
        if(self.setCountOfRowsInSection){
            return self.setCountOfRowsInSection(section);
        }else{
            if([self isMultiDatas]){
                NSArray *sectionArr = [self.mainDataArr objectAtIndex:section];
                if(![sectionArr isKindOfClass:[NSArray class]]){
                    NSAssert(NO, @"数据源内容不符合要求，多section情况数据源中必须皆为数组！");
                    return 0;
                }
                return sectionArr.count;
            }else{
                return self.mainDataArr.count;
            }
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self.tableDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        return [self.tableDataSource numberOfSectionsInTableView:tableView];
    }else{
        if(self.setCountOfSectionsInTableView){
            return self.setCountOfSectionsInTableView(tableView);
        }else{
            return [self isMultiDatas] ? self.mainDataArr.count : 1;
        }
    }
}

#pragma mark - UITableViewDelegate
#pragma mark tableView 选中某一indexPath
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deselectRowAtIndexPath:indexPath animated:YES];
    if([self.tableDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.tableDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
        [self deselectRowAtIndexPath:indexPath animated:YES];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        !self.didSelectedAtIndexPath ? : self.didSelectedAtIndexPath(indexPath,cell);
    }
}
#pragma mark tableView 取消选中某一indexPath
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.tableDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]){
        [self.tableDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        !self.didDeselectedAtIndexPath ? : self.didDeselectedAtIndexPath(indexPath,cell);
    }
}
#pragma mark tableView 滑动编辑
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.editActionsForRowAtIndexPath){
        return self.editActionsForRowAtIndexPath(indexPath);
    }else{
        return nil;
    }
}
#pragma mark tableView 是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.editActionsForRowAtIndexPath){
        NSArray *rowActionsArr = self.editActionsForRowAtIndexPath(indexPath);
        if(rowActionsArr && ![rowActionsArr isKindOfClass:[NSNull class]] && rowActionsArr.count){
            return YES;
        }
    }
    return NO;
}
#pragma mark tableView cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tableDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return UITableViewAutomaticDimension;
    }
    if([self.tableDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        return [self.tableDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        if(self.setCellHeightAtIndexPath){
            return self.setCellHeightAtIndexPath(indexPath);
        }else{
            return 44;
        }
    }
}
#pragma mark tableView cell 将要展示
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.willDisplayCell ? : self.willDisplayCell(indexPath,cell);
}
#pragma mark tableView HeaderView & FooterView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = nil;
    if([self.tableDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]){
        headerView = [self.tableDelegate tableView:tableView viewForHeaderInSection:section];
        
    }else{
        if(self.setHeaderViewInSection){
            headerView = self.setHeaderViewInSection(section);
        }
    }
    NSMutableArray *secArr = self.mainDataArr.count ? [self isMultiDatas] ? self.mainDataArr[section] : self.mainDataArr : nil;
    !self.getHeaderViewInSection ? : self.getHeaderViewInSection(section,headerView,secArr);
    return !secArr.count ? self.showHeaderWhenNoData ? headerView : nil : headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = nil;
    if([self.tableDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]){
        footerView = [self.tableDelegate tableView:tableView viewForFooterInSection:section];
        
    }else{
        if(self.setFooterViewInSection){
            footerView = self.setFooterViewInSection(section);
        }
    }
    NSMutableArray *secArr = self.mainDataArr.count ? [self isMultiDatas] ? self.mainDataArr[section] : self.mainDataArr : nil;
    !self.getFooterViewInSection ? : self.getFooterViewInSection(section,footerView,secArr);
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self.tableDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]){
        return [self.tableDelegate tableView:tableView heightForHeaderInSection:section];
        
    }else{
        if(self.setHeaderHeightInSection){
            return self.setHeaderHeightInSection(section);
        }else{
            return CGFLOAT_MIN;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if([self.tableDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
        return [self.tableDelegate tableView:tableView heightForFooterInSection:section];
        
    }else{
        if(self.setFooterHeightInSection){
            return self.setFooterHeightInSection(section);
        }else{
            return CGFLOAT_MIN;
        }
    }
}

#pragma mark 声明cell的类并返回cell对象
-(void)setCellAtIndexPath:(SetCellAtIndexPath)setCellCallBack returnCell:(GetCellAtIndexPath)returnCellCallBack{
    self.setCellAtIndexPath = setCellCallBack;
    self.getCellAtIndexPath = returnCellCallBack;
}
#pragma mark 声明HeaderView的类并返回HeaderView对象
-(void)setHeaderViewInSection:(SetHeaderViewInSection)setHeaderViewCallBack returnHeader:(GetHeaderViewInSection)returnHeaderCallBack{
    self.setHeaderViewInSection = setHeaderViewCallBack;
    self.getHeaderViewInSection = returnHeaderCallBack;
}
#pragma mark 声明FooterView的类并返回FooterView对象
-(void)setFooterViewInSection:(SetFooterViewInSection)setFooterViewCallBack returnHeader:(GetFooterViewInSection)returnFooterCallBack{
    self.setFooterViewInSection = setFooterViewCallBack;
    self.getFooterViewInSection = returnFooterCallBack;
}
#pragma mark - scrollView相关代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self.tableDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        return [self.tableDelegate scrollViewDidScroll:scrollView];
        
    }else{
        if(self.scrollViewDidScroll){
            self.scrollViewDidScroll(scrollView);
        }
    }
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if([self.tableDelegate respondsToSelector:@selector(scrollViewDidZoom:)]){
        return [self.tableDelegate scrollViewDidZoom:scrollView];
        
    }else{
        if(self.scrollViewDidZoom){
            self.scrollViewDidZoom(scrollView);
        }
    }
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if([self.tableDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]){
        return [self.tableDelegate scrollViewDidScrollToTop:scrollView];
        
    }else{
        if(self.scrollViewDidScrollToTop){
            self.scrollViewDidScrollToTop(scrollView);
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([self.tableDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        return [self.tableDelegate scrollViewWillBeginDragging:scrollView];
        
    }else{
        if(self.scrollViewWillBeginDragging){
            self.scrollViewWillBeginDragging(scrollView);
        }
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if([self.tableDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        return [self.tableDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        
    }else{
        if(self.scrollViewDidEndDragging){
            self.scrollViewDidEndDragging(scrollView,decelerate);
        }
    }
}

@end
