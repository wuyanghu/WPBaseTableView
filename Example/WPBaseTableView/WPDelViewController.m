//
//  WPDelViewController.m
//  WPBaseTableView_Example
//
//  Created by wupeng on 2020/1/11.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import "WPDelViewController.h"

@interface WPDelViewController ()

@end

@implementation WPDelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)isCellEditingDelete{
    return YES;
}

- (void)cellEditingDeleteAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"删除和刷新就自己实现吧");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
