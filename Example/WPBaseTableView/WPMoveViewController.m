//
//  WPEditViewController.m
//  WPBaseTableView_Example
//
//  Created by wupeng on 2020/1/11.
//  Copyright © 2020 823105162@qq.com. All rights reserved.
//

#import "WPMoveViewController.h"
#import "UIBu"
@interface WPMoveViewController ()

@end

@implementation WPMoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setEditing:YES animated:YES];
    
    UIButton * button =
    [UIButton.createButton wp_makeProperty:^(ButtonChainedMaker * _Nullable make) {
        make.frame(CGRectMake(0, 0, 44, 44));
        make.image(image,UIControlStateNormal);
        make.addTarget(callBlock);
    }];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem cu]
}

- (BOOL)isCellCanMove{
    return YES;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"移动自己实现吧!");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
