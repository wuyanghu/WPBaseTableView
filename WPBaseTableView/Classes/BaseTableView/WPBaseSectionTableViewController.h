//
//  BaseSectionTableViewViewController.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPBaseSectionModel.h"
#import "UITableViewCell+WPBaseTableView.h"
#import "WPBaseSectionTableViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseSectionTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WPBaseTableViewCellConfig>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) WPBaseSectionsModel * sectionsModel;

#pragma mark - tableview方法
- (void)requestData:(BOOL)isRefresh;
//以下方法子类可重载
@property (nonatomic,assign) WPBaseSectionTableViewLoadType loadType;//默认网络数据,

#pragma mark - 占位
- (void)plactHolderRefreshAction;//占位刷新:子类实现
#pragma mark - 浏览相册
- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl;
//提供一个默认的section
- (WPBaseSectionModel *)defaultSectionsModel;
@end

NS_ASSUME_NONNULL_END



