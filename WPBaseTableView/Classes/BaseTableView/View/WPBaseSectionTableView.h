//
//  WPBaseSectionTableView.h
//  WPBaseTableView
//
//  Created by wupeng on 2020/2/25.
//

#import <UIKit/UIKit.h>
#import "WPBaseSectionTableViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseSectionTableView : UIView
@property (nonatomic,weak) id<WPBaseTableViewCellConfig> cellConfigDelegate;
@property (nonatomic,weak) id<WPBaseTableViewHeaderFooterConfig> headerFooterConfigDelegate;
@property (nonatomic,weak) id<WPBaseTableViewPlaceHolder> placeHolderDelegate;
@property (nonatomic,weak) id<WPBaseTableViewCellDelete> delDelegate;
@property (nonatomic,weak) id<WPBaseTableViewCellMove> moveDelegate;
@property (nonatomic,weak) id<WPBaseTableViewPlaceBrowser> browserDelegate;
@property (nonatomic,weak) id<WPBaseTableViewData> tableViewData;
@property (nonatomic,weak) id<WPBaseTableViewDidSelectRow> didSelectRow;
@property (nonatomic,weak) id<WPBaseTableViewHeaderFooterRefresh> headerFooterRefresh;
- (UITableView *)getTableView;

@end

NS_ASSUME_NONNULL_END
