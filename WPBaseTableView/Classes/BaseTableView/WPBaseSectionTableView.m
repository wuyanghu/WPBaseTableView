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

@interface WPBaseSectionTableView()
@property (nonatomic,weak) id<UITableViewDataSource> dataSource;
@property (nonatomic,weak) id<UITableViewDelegate> delegate;
@property (nonatomic,weak) id<WPBaseSectionTableViewDelegate> initDataDelegate;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation WPBaseSectionTableView

- (instancetype)initWithDataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate initDataDelegate:(id<WPBaseSectionTableViewDelegate>)initDataDelegate{
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        _delegate = delegate;
        _initDataDelegate = initDataDelegate;
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
    self.tableView.placeHolderView.frame = self.bounds;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.dataSource = self.dataSource;
        _tableView.delegate = self.delegate;
        [self setPlaceHolderTableView:_tableView];
        
        [WPBaseSectionCell registerClassWithTableView:_tableView];
        [WPBaseHeaderFooterView registerHeaderFooterClassWithTableView:_tableView];
        
        if (self.initDataDelegate) [self.initDataDelegate sectionTableViewInitData:_tableView];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

//设置占位
- (void)setPlaceHolderTableView:(UITableView *)tableView{
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

@end
