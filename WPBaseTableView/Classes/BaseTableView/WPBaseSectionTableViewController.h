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
@property (nonatomic,strong) WPBaseSectionsModel * sectionsModel;

@end

NS_ASSUME_NONNULL_END



