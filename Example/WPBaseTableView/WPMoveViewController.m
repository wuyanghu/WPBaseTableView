//
//  WPEditViewController.m
//  WPBaseTableView_Example
//
//  Created by wupeng on 2020/1/11.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import "WPMoveViewController.h"
#import "UINavigationItem+WPAddBarButtonItem.h"
#import "WPCustomCell.h"

@interface WPMoveViewController ()

@end

@implementation WPMoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem wp_makeNaviItem:^(WPNavigationChainedMaker * _Nullable make) {
        make.addRightItemTitle(@"编辑",^(UIButton * button){
            [self.tableView setEditing:!self.tableView.isEditing animated:YES];
            if (self.tableView.isEditing) {
                [button setTitle:@"完成" forState:UIControlStateNormal];
            }else{
                [button setTitle:@"编辑" forState:UIControlStateNormal];
            }
        });
    }];
}

#pragma mark - tableView delegate

#pragma mark WPBaseTableViewCellConfig
- (void)registerCellTableView:(UITableView *)tableView{
    [super registerCellTableView:tableView];
    [WPCustomCell registerClassWithTableView:tableView];
}

- (NSString *)cellIdentifyWithIndexPath:(NSIndexPath *)indexPath{
    return WPCustomCell.cellIdentifier;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = [[self.sectionsModel getContentModelWithIndexPath:indexPath] title];
}

#pragma mark WPBaseTableViewCellMove

- (BOOL)isCellCanMove{
    return YES;
}

- (BOOL)isCellEditingDelete{
    return YES;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"移动自己实现吧!");
}

@end
