//
//  WPCustomCellViewController.m
//  WPBaseTableView_Example
//
//  Created by wupeng on 2020/1/11.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import "WPCustomCellViewController.h"
#import "WPCustomCell.h"
#import "WPCustomXibCell.h"
@interface WPCustomCellViewController ()

@end

@implementation WPCustomCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)registerCell{
    [super registerCell];
    [WPCustomCell registerClassWithTableView:self.tableView];
    [WPCustomXibCell registerNibWithTableView:self.tableView];
}

- (NSString *)cellIdentifyWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return WPCustomCell.cellIdentifier;
    }else if (indexPath.row == 1){
        return WPCustomXibCell.cellIdentifier;
    }
    return [super cellIdentifyWithIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    WPBaseRowModel * rowModel = [self.sectionsModel getContentModelWithIndexPath:indexPath];
    if ([cell isKindOfClass:[WPCustomCell class]]) {
        NSLog(@"我是纯代码cell");
        cell.textLabel.text = rowModel.title;
    }else if ([cell isKindOfClass:[WPCustomXibCell class]]){
        NSLog(@"我是xibcell");
        WPCustomXibCell * xibCell = (WPCustomXibCell *)cell;
        xibCell.titleLabel.text = rowModel.title;
    }else{
        [super configureCell:cell atIndexPath:indexPath];
    }
}

@end
