//
//  BaseSectionTableViewViewController.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "WPBaseSectionTableViewController.h"
#import "NSObject+WPBaseTableView.h"
#import "WPBaseSectionCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WPBaseSectionModel.h"
#import "WPParseSectionsModel.h"
#import "WPBaseHeader.h"
#import "WPBaseHeaderFooterView.h"
#import "WPBaseSectionTableView.h"
#import "UITableViewHeaderFooterView+WPBaseCategory.h"

@interface WPBaseSectionTableViewController ()<WPBaseTableViewCellConfig,WPBaseTableViewHeaderFooterConfig,WPBaseTableViewCellMove,WPBaseTableViewCellDelete,WPBaseTableViewPlaceBrowser,WPBaseTableViewPlaceHolder,WPBaseTableViewData,WPBaseTableViewDidSelectRow,WPBaseTableViewHeaderFooterRefresh>
@property (nonatomic,strong) WPBaseSectionTableView * sectionTableView;
@end

@implementation WPBaseSectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.sectionTableView];
    
    [self loadData:NO];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.sectionTableView.frame = self.view.bounds;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 载入配置信息

- (WPBaseSectionTableViewLoadType)loadType{
    NSData * data = [self readJsonDataWithName:NSStringFromClass([self class])];
    if(data){
        return WPBaseSectionTableViewLoadLocalType;
    }else{
        return WPBaseSectionTableViewNoLoadType;
    }
}

#pragma mark - 加载数据

- (void)loadData:(BOOL)isRefresh{
    if (self.loadType == WPBaseSectionTableViewLoadLocalType){
        [self loadLocalJsonData];
    }else if(self.loadType == WPBaseSectionTableViewRequestType){
        [self requestData:isRefresh];
    }
}

//不请求数据
- (void)loadNoData{}

//加载本地数据
- (void)loadLocalJsonData{
    id json = [self readJsonWithName:NSStringFromClass([self class])];
    self.sectionsModel =  [WPParseSectionsModel parseLocalJsonToBaseSetcionModel:json];
    [self.tableView reloadData];
}

//请求网络数据
- (void)requestData:(BOOL)isRefresh{}

#pragma mark - WPBaseTableViewHeaderFooterRefresh

- (BOOL)hideRefreshHeader{
    return NO;
}

- (void)refreshHeaderActionWithTableView:(UITableView *)tableView finshBlock:(void (^)(void))block{
    block();
}

- (BOOL)hideRefreshFooter{
    return NO;
}

- (void)refreshFooterActionWithTableView:(UITableView *)tableView finshBlock:(void (^)(BOOL))block{
    block(NO);
}

#pragma mark - WPBaseTableViewPlaceHolder
- (void)placeHolderRefreshAction{}

#pragma mark - 浏览图片
- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl{}

#pragma mark - WPBaseTableViewCellConfig

- (void)registerCellTableView:(UITableView *)tableView{}

- (NSString *)cellIdentifyWithIndexPath:(NSIndexPath *)indexPath{
    return WPBaseSectionCell.cellIdentifier;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[WPBaseSectionCell class]]) {
        CMWeakSelf;
        WPBaseSectionCell * sectionCell = (WPBaseSectionCell *)cell;
        sectionCell.callBlock = ^() {
            CMStrongSelf;
            [self photoBrowserWithIndexPath:indexPath isUrl:YES];
        };
    }
}

#pragma mark - WPBaseTableViewHeaderFooterConfig

- (BOOL)hideHeaderFooterView{
    return NO;
}

- (void)registerHeaderFooterView{}

- (NSString *)headerFooterViewIdentifyWithSection:(NSInteger)section{
    return WPBaseHeaderFooterView.cellIdentifier;
}

- (void)configureHeaderFooterView:(UITableViewHeaderFooterView *)view section:(NSInteger)section{
    if ([view isKindOfClass:[WPBaseHeaderFooterView class]]) {
        WPBaseHeaderFooterView * headerView = (WPBaseHeaderFooterView *)view;
        CMWeakSelf;
        headerView.block = ^{
            CMStrongSelf;
            NSMutableArray *indexPaths = [NSMutableArray array];
            
            WPBaseSectionModel * sectionModel = self.sectionsModel.contentArray[section];
            for (int i = 0;i<sectionModel.rowArray.count;i++) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
            }
            if (sectionModel.expend) {
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }
        };
    }
}

#pragma mark - WPBaseTableViewDidSelectRow

- (WPBaseSectionsModel *)getSectionsModel{
    return self.sectionsModel;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WPBaseRowModel * contentModel = [self.sectionsModel getContentModelWithIndexPath:indexPath];
    NSString * className = contentModel.classname;
    NSString * storyBoardName = contentModel.storyboardname;
    
    id objClass = nil;
    if (storyBoardName && storyBoardName.length>0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
        objClass = [storyboard instantiateViewControllerWithIdentifier:className];
    }else{
        objClass = [NSClassFromString(className) new];
    }
    if (!objClass) {//对象是空直接return
        return;
    }
    
    if (contentModel.params) {
        [objClass setWpAddParams:contentModel.params];
    }
    
    if (!contentModel.method || contentModel.method.length == 0) {//没有指定方法，如果是viewController默认调push方法
        if ([objClass isKindOfClass:[UIViewController class]]) {
            [self.navigationController pushViewController:objClass animated:YES];
        }
    }else{
        SEL selector = NSSelectorFromString(contentModel.method);
        if ([objClass respondsToSelector:selector]) {
            ((void (*)(id, SEL))[objClass methodForSelector:selector])(objClass, selector);
        }
    }
}

#pragma mark - WPBaseTableViewCellDelete

- (BOOL)isCellEditingDelete{
    return NO;
}

- (void)cellEditingDeleteAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"编辑删除");//具体操作，子类实现
}

#pragma mark - WPBaseTableViewCellMove

- (BOOL)isCellCanMove{
    return NO;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{}

#pragma mark - getter

//提供一个默认的section
- (WPBaseSectionModel *)defaultSectionsModel{
    if (!self.sectionsModel) {
        self.sectionsModel = [WPBaseSectionsModel new];
        WPBaseSectionModel * sectionModel = [WPBaseSectionModel new];
        [self.sectionsModel.contentArray addObject:sectionModel];
    }
    return self.sectionsModel.contentArray.firstObject;
}

- (UITableView *)tableView{
    return [_sectionTableView getTableView];
}

- (WPBaseSectionTableView *)sectionTableView{
    if (!_sectionTableView) {
        _sectionTableView = [[WPBaseSectionTableView alloc] init];
        _sectionTableView.cellConfigDelegate = self;
        _sectionTableView.headerFooterConfigDelegate = self;
        _sectionTableView.placeHolderDelegate = self;
        _sectionTableView.delDelegate = self;
        _sectionTableView.moveDelegate = self;
        _sectionTableView.browserDelegate = self;
        _sectionTableView.tableViewData = self;
        _sectionTableView.didSelectRow = self;
        _sectionTableView.headerFooterRefresh = self;
    }
    return _sectionTableView;
}

@end







