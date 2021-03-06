//
//  WPBaseSectionTableViewHeader.h
//  WPBaseTableView
//
//  Created by wupeng on 2020/2/24.
//

#ifndef WPBaseSectionTableViewHeader_h
#define WPBaseSectionTableViewHeader_h

#pragma mark - 数据源

#import "WPBaseSectionModel.h"
@protocol WPBaseTableViewData <NSObject>
- (WPBaseSectionsModel *)getSectionsModel;
@end

#pragma mark - cell

@protocol WPBaseTableViewCellConfig <NSObject>

- (UITableView *)tableView;
- (void)registerCellTableView:(UITableView *)tableView;
- (NSString *)cellIdentifyWithIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - headerFooter

@protocol WPBaseTableViewHeaderFooterConfig <NSObject>

- (BOOL)hideHeaderFooterView;
- (void)registerHeaderFooterView;
- (NSString *)headerFooterViewIdentifyWithSection:(NSInteger)section;
- (void)configureHeaderFooterView:(UITableViewHeaderFooterView *)view section:(NSInteger)section;

@end

#pragma mark - 上拉、下拉刷新
@protocol WPBaseTableViewHeaderFooterRefresh <NSObject>
@optional
- (BOOL)hideRefreshHeader;
- (BOOL)hideRefreshFooter;
- (void)refreshHeaderActionWithTableView:(UITableView *)tableView finshBlock:(void(^)(void))block;
- (void)refreshFooterActionWithTableView:(UITableView *)tableView finshBlock:(void(^)(BOOL isMore))block;

@end

#pragma mark - 移动

@protocol WPBaseTableViewCellMove <NSObject>

- (BOOL)isCellCanMove;//是否支持移动
- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

#pragma mark - 删除

@protocol WPBaseTableViewCellDelete <NSObject>
- (BOOL)isCellEditingDelete;//是否支持删除
- (void)cellEditingDeleteAtIndexPath:(NSIndexPath *)indexPath;//左滑删除
@end

#pragma mark - 占位
@protocol WPBaseTableViewPlaceHolder <NSObject>
- (void)placeHolderRefreshAction;
@end

#pragma mark - 浏览图片
@protocol WPBaseTableViewPlaceBrowser <NSObject>
- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl;
@end

@protocol WPBaseTableViewDidSelectRow <NSObject>
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

#endif /* WPBaseSectionTableViewHeader_h */
