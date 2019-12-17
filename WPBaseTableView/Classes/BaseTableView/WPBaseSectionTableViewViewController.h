//
//  BaseSectionTableViewViewController.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPBaseSectionModel.h"
#import "UITableViewCell+BaseCategory.h"

typedef enum:NSInteger {
    WPBaseSectionTableViewNoLoadType,//不加载数据,子类实现
    WPBaseSectionTableViewLoadLocalType,//加载本地json文件
    WPBaseSectionTableViewRequestType//请求网络数据
}WPBaseSectionTableViewLoadType;

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseSectionTableViewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) WPBaseSectionsModel * sectionsModel;

#pragma mark - tableview方法
//以下方法子类可重载
@property (nonatomic,assign) WPBaseSectionTableViewLoadType loadType;//默认网络数据,
@property (nonatomic,copy) NSString * cellIdentify;
- (void)registerCell;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,copy) NSString * headerFooterViewCellIdentify;
- (void)registerHeaderFooterView;
- (void)configureHeaderFooterView:(UITableViewHeaderFooterView *)view section:(NSInteger)section;

#pragma mark - 浏览相册
- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl;
//提供一个默认的section
- (WPBaseSectionModel *)defaultSectionsModel;
@end

NS_ASSUME_NONNULL_END



