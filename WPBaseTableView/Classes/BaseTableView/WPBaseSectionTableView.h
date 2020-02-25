//
//  WPBaseSectionTableView.h
//  WPBaseTableView
//
//  Created by wupeng on 2020/2/25.
//

#import <UIKit/UIKit.h>
#import "WPBaseSectionTableViewHeader.h"
NS_ASSUME_NONNULL_BEGIN

@protocol WPBaseSectionTableViewDelegate <NSObject>
- (void)sectionTableViewInitData:(UITableView *)tableView;
@end

@interface WPBaseSectionTableView : UIView
@property (nonatomic,weak) id<WPBaseTableViewPlaceHolder> placeHolderDelegate;

- (instancetype)initWithDataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate initDataDelegate:(id<WPBaseSectionTableViewDelegate>)initDataDelegate;
- (UITableView *)getTableView;

@end

NS_ASSUME_NONNULL_END
