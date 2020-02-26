//
//  WPBaseSectionTableViewControllerHeader.h
//  WPBaseTableView
//
//  Created by wupeng on 2020/2/25.
//

#ifndef WPBaseSectionTableViewControllerHeader_h
#define WPBaseSectionTableViewControllerHeader_h

#import "WPBaseSectionModel.h"

typedef enum:NSInteger {
    WPBaseSectionTableViewNoLoadType,//不加载数据,子类实现
    WPBaseSectionTableViewLoadLocalType,//加载本地json文件
    WPBaseSectionTableViewRequestType//请求网络数据
}WPBaseSectionTableViewLoadType;

#pragma mark - 提供默认数据

@protocol WPBaseTableViewControllerDefualtModel <NSObject>
@optional;
- (WPBaseSectionModel *)defaultSectionsModel;
@end

#pragma mark - 请求数据

@protocol WPBaseTableViewControllerRequest <NSObject>
- (WPBaseSectionTableViewLoadType)loadType;
- (void)requestData:(BOOL)isRefresh;
@end

#endif /* WPBaseSectionTableViewControllerHeader_h */
