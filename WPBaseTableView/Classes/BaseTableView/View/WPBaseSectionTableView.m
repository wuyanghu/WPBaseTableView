//
//  WPBaseSectionTableView.m
//  WPBaseTableView
//
//  Created by wupeng on 2020/2/25.
//

#import "WPBaseSectionTableView.h"
#import "WPBaseSectionCell.h"
#import "UITableViewHeaderFooterView+WPBaseCategory.h"
#import "UITableView+Placeholder.h"
#import "UITableViewCell+WPBaseTableView.h"
#import "WPTableViewPlaceHolderView.h"
#import "WPBaseHeaderFooterView.h"
#import "WPBaseHeader.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface WPBaseSectionTableView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation WPBaseSectionTableView

#pragma mark - 构造view

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
    self.tableView.placeHolderView.frame = self.bounds;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_tableView];
        [self addPlaceHolderView:_tableView];
        
        [WPBaseSectionCell registerClassWithTableView:_tableView];
        [WPBaseHeaderFooterView registerHeaderFooterClassWithTableView:_tableView];
        if (self.cellConfigDelegate) [self.cellConfigDelegate registerCellTableView:_tableView];
        if (self.headerFooterConfigDelegate) [self.headerFooterConfigDelegate registerHeaderFooterView];
    }
    return _tableView;
}

//设置占位
- (void)addPlaceHolderView:(UITableView *)tableView{
    CMWeakSelf;
    id placeHolderView = [[WPTableViewPlaceHolderView alloc] initWithFrame:self.frame refreshBlock:^{
        CMStrongSelf;
        if (self.placeHolderDelegate) [self.placeHolderDelegate placeHolderRefreshAction];
    }];
    [tableView setPlaceHolderView:placeHolderView];
}

- (UITableView *)getTableView{
    return self.tableView;
}

#pragma mark - tableView

#pragma mark header
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.headerFooterConfigDelegate) {
        return nil;
    }
    if ([self.headerFooterConfigDelegate hideHeaderFooterView]){
        return nil;
    }
    
    WPBaseHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self.headerFooterConfigDelegate headerFooterViewIdentifyWithSection:section]];
    [self.headerFooterConfigDelegate configureHeaderFooterView:headerView section:section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.headerFooterConfigDelegate) {
        return 0.01f;
    }
    
    if ([self.headerFooterConfigDelegate hideHeaderFooterView]) {
        return 0.01f;
    }
        
    NSString * identifier = [self.headerFooterConfigDelegate headerFooterViewIdentifyWithSection:section];
    return [tableView fd_heightForHeaderFooterViewWithIdentifier:identifier configuration:^(id headerFooterView) {
        [self.headerFooterConfigDelegate configureHeaderFooterView:headerFooterView section:section];
    }];
}

#pragma mark content

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellConfigDelegate) {
        return 0.01f;
    }
    return [tableView fd_heightForCellWithIdentifier:[self.cellConfigDelegate cellIdentifyWithIndexPath:indexPath] cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        [self.cellConfigDelegate configureCell:cell atIndexPath:indexPath];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WPBaseSectionsModel * sectionsModel = [self.tableViewData getSectionsModel];
    WPBaseSectionModel * sectionModel = sectionsModel.contentArray[section];
    if (sectionModel.expend) {
        return 0;
    }
    
    return sectionModel.rowArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    WPBaseSectionsModel * sectionsModel = [self.tableViewData getSectionsModel];
    return sectionsModel.contentArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * identifier = [self.cellConfigDelegate cellIdentifyWithIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [self.cellConfigDelegate configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRow) {
        [self.didSelectRow didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark 左滑删除

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isCellDel = NO;
    if (self.delDelegate) {
        isCellDel =  [self.delDelegate isCellEditingDelete];
    }
    return isCellDel;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (self.delDelegate) [self.delDelegate cellEditingDeleteAtIndexPath:indexPath];
    }
}

#pragma mark - 移动

// 设置 cell 是否允许移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isMove = NO;
    if (self.moveDelegate) {
        isMove = [self.moveDelegate isCellCanMove];
    }
    return isMove;
}
// 移动 cell 时触发
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 移动cell之后更换数据数组里的循序
    if (self.moveDelegate) {
        [self.moveDelegate moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

@end
