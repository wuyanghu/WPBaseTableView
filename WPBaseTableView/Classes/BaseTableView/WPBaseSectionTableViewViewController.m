//
//  BaseSectionTableViewViewController.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/9/18.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "WPBaseSectionTableViewViewController.h"
#import "NSObject+AddParams.h"
#import "UITableViewHeaderFooterView+WPBaseCategory.h"
#import "WPBaseSectionCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WPBaseSectionModel.h"
#import "WPRequestVCJsonAPI.h"
#import "WPParseVCJsonAPI.h"
#import "NSObject+Json.h"
#import "WPBaseHeader.h"
#import "MJRefresh.h"
#import "WPTableViewPlaceHolderView.h"
#import "UITableView+Placeholder.h"
#import "CMPhotoBrowserViewController.h"
#import "WPBaseHeaderFooterView.h"

@interface WPBaseSectionTableViewViewController ()
@property (nonatomic,strong) WPRequestVCJsonAPI * requestVCJsonApi;
@end

@implementation WPBaseSectionTableViewViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadConfigInfo];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vcJsonChanged) name:kVCJsonChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchConfigUrl) name:kSwitchConfigUrlNotification object:nil];
    
    [self loadData:NO];
}

- (void)addSubView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    CMWeakSelf;
    WPTableViewPlaceHolderView * placeHolderView = [[WPTableViewPlaceHolderView alloc] initWithFrame:self.view.frame refreshBlock:^{
        CMStrongSelf;
        [self loadData:NO];
    }];
    [self.tableView setPlaceHolderView:placeHolderView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        CMStrongSelf;
        [self loadData:YES];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知

- (void)vcJsonChanged{
    [self loadData:NO];
}

- (void)switchConfigUrl{
    [self loadConfigInfo];
}

#pragma mark - 加载数据

- (void)loadData:(BOOL)isRefresh{
    if (self.loadType == WPBaseSectionTableViewNoLoadType) {
        [self.tableView.mj_header endRefreshing];
    }else if (self.loadType == WPBaseSectionTableViewLoadLocalType){
        [self loadLocalJson];
        [self.tableView.mj_header endRefreshing];
    }else if(self.loadType == WPBaseSectionTableViewRequestType){
        [self requestDetailInfo:isRefresh];
    }
}

//加载本地数据
- (void)loadLocalJson{
    id json = [self readJsonWithName:NSStringFromClass([self class])];
    self.sectionsModel =  [WPParseVCJsonAPI parseLocalJsonToBaseSetcionModel:json];
    [self.tableView reloadData];
}

//request
- (void)requestDetailInfo:(BOOL)isRefresh{
    if (isRefresh) {
        [self.tableView.mj_header beginRefreshing];
    }
    [self.requestVCJsonApi queryClassNameDetailInfoWithClassName:NSStringFromClass([self class]) block:^(WPBaseNetWorkModel * model, NSError *error) {
        if (isRefresh) {
            [self.tableView.mj_header endRefreshing];
        }
        if (error) {
            id json = [self readJsonWithName:NSStringFromClass([self class])];
            self.sectionsModel =  [WPParseVCJsonAPI parseLocalJsonToBaseSetcionModel:json];
        }else{
            self.sectionsModel =  [WPParseVCJsonAPI parseServerJsonToBaseSetcionModel:model.dictFromResult];
        }
        [self.tableView reloadData];
    }];
    
}

- (void)loadConfigInfo{
    WPBaseNetWorkConfig * netWorkConfig = [[WPBaseNetWorkConfig alloc] init];
    NSData * data = [self readJsonDataWithName:NSStringFromClass([self class])];
    if (netWorkConfig.urlString.length>0) {
        _loadType = WPBaseSectionTableViewRequestType;
    }else if(data){
        _loadType = WPBaseSectionTableViewLoadLocalType;
    }
}
//提供一个默认的section
- (WPBaseSectionModel *)defaultSectionsModel{
    if (!self.sectionsModel) {
        self.sectionsModel = [WPBaseSectionsModel new];
        WPBaseSectionModel * sectionModel = [WPBaseSectionModel new];
        [self.sectionsModel.contentArray addObject:sectionModel];
    }
    return self.sectionsModel.contentArray.firstObject;
}

#pragma mark - 浏览图片

- (void)photoBrowserWithIndexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl{
    WPBaseSectionModel * sectionModel = self.sectionsModel.contentArray[indexPath.section];
    __block NSInteger newIndex = indexPath.row;
    NSMutableArray * urlArray = [NSMutableArray arrayWithCapacity:3];
    [sectionModel.rowArray enumerateObjectsUsingBlock:^(WPBaseRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.imageModel.url) {
            [urlArray addObject:obj.imageModel.url];//过滤掉没有url的
        }
        if (idx<indexPath.row && obj.imageModel.url.length == 0) {
            newIndex --;//计算index的偏移,需要过滤掉没有url
        }
    }];
    
    NSArray * reusltArray = [self indexprePostArrayWithArray:urlArray index:newIndex];//纯计算偏移
    
    if (newIndex == 0) {
        newIndex = 0;
    }else if (newIndex == urlArray.count-1){
        newIndex = 2;
    }else{
        newIndex = 1;
    }
    
    if (newIndex>=reusltArray.count) {
        newIndex = 0;
    }
    NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:indexPath.section];
    [self presentPhotoBrowserVC:reusltArray indexPath:newIndexPath isUrl:YES];
}
/*
 返回index前后NSArray
 怎么浏览三张,当前这张在中间;保证数组前后不能越界?
 如果是在第0个位置,数量够时,取0,1,2;如果是最后一个位置,取最后一个位置
 扩展:如果是4张，5张呢?算法的扩展性
 */
- (NSArray *)indexprePostArrayWithArray:(NSArray *)array index:(NSInteger)index{
    NSAssert(index>=0 && index<array.count, @"index应在数组范围内");
    NSInteger beign = index-1;
    NSInteger end = index+1;
    
    NSMutableArray * resultArray = [NSMutableArray arrayWithCapacity:3];
    
    if (beign<0) {
        end = end-beign;//减去负值
        beign = 0;
        if (end >= array.count) {
            end = array.count - 1;
        }
    }else if(end>=array.count){
        NSInteger absolute = end-(array.count-1);
        beign = beign-absolute;
        end = array.count-1;
        if (beign<0) {
            beign = 0;
        }
    }
    
    NSAssert(beign>=0, @"begin不会小于0");
    NSAssert(end<array.count, @"end不能大于等于count");
    
    for (NSInteger i = beign; i<=end; i++) {
        [resultArray addObject:array[i]];
    }
    if (array.count>=3) {
        NSAssert(resultArray.count == 3, @"应该有3个");
    }else{
        NSAssert(resultArray.count == array.count, @"与数组个数相等");
    }
    
    return resultArray;
}

//模态图片浏览
- (void)presentPhotoBrowserVC:(NSArray *)imageArray indexPath:(NSIndexPath *)indexPath isUrl:(BOOL)isUrl{
    CMPhotoBrowserViewController *photoVC = [[CMPhotoBrowserViewController alloc]init];
    if (isUrl) {
        photoVC.smallImageURLs = imageArray;
        photoVC.imageURLs = imageArray;
    }else{
        photoVC.imageArray = imageArray;
    }
    NSInteger index = indexPath.row;
    if (index>=imageArray.count) {
        index = 0;
    }
    photoVC.index = index;
    
    CMPhotoBrowserAnimator * animator = [[CMPhotoBrowserAnimator alloc] init];
    animator.index = index;
    animator.animationDismissDelegate = photoVC;
    photoVC.transitioningDelegate = animator;
    photoVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:photoVC animated:YES completion:nil];
}

#pragma mark - configcell

- (void)registerCell{
    [WPBaseSectionCell registerClassWithTableView:_tableView];
}

- (NSString *)cellIdentify{
    return WPBaseSectionCell.cellIdentifier;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[WPBaseSectionCell class]]) {
        CMWeakSelf;
        WPBaseSectionCell * sectionCell = (WPBaseSectionCell *)cell;
        sectionCell.sectionContentModel = [self.sectionsModel getContentModelWithIndexPath:indexPath];
        sectionCell.callBlock = ^() {
            CMStrongSelf;
            [self photoBrowserWithIndexPath:indexPath isUrl:YES];
        };
    }
}

#pragma mark - configHeader

- (void)registerHeaderFooterView{
    [WPBaseHeaderFooterView registerHeaderFooterClassWithTableView:_tableView];
}

- (NSString *)headerFooterViewCellIdentify{
    return WPBaseHeaderFooterView.cellIdentifier;
}

- (void)configureHeaderFooterView:(UITableViewHeaderFooterView *)view section:(NSInteger)section{
    if ([view isKindOfClass:[WPBaseHeaderFooterView class]]) {
        WPBaseHeaderFooterView * headerView = (WPBaseHeaderFooterView *)view;
        headerView.sectionModel = self.sectionsModel.contentArray[section];
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

#pragma mark - tableView

#pragma mark header
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WPBaseHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerFooterViewCellIdentify];
    [self configureHeaderFooterView:headerView section:section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [tableView fd_heightForHeaderFooterViewWithIdentifier:self.headerFooterViewCellIdentify configuration:^(id headerFooterView) {
        [self configureHeaderFooterView:headerFooterView section:section];
    }];
}

#pragma mark content

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:self.cellIdentify cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WPBaseSectionModel * sectionModel = self.sectionsModel.contentArray[section];
    if (sectionModel.expend) {
        return 0;
    }
    return sectionModel.rowArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionsModel.contentArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:self.cellIdentify forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
        [objClass setParams:contentModel.params];
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

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self registerCell];
        [self registerHeaderFooterView];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (WPRequestVCJsonAPI *)requestVCJsonApi{
    if (!_requestVCJsonApi) {
        _requestVCJsonApi = [WPRequestVCJsonAPI new];
    }
    return _requestVCJsonApi;
}

@end







