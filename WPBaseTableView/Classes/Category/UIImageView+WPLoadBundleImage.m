//
//  UIImageView+WPLoadBundleImage.m
//  WPBase
//
//  Created by wupeng on 2019/11/21.
//

#import "UIImageView+WPLoadBundleImage.h"

@implementation UIImageView (WPLoadBundleImage)

- (void)wpLoadBundelImageWithName:(NSString *)imgName
{
    NSBundle *bundle = [self.class wp_tableViewBundle];
    UIImage *image = [UIImage imageNamed:imgName inBundle:bundle compatibleWithTraitCollection:nil];
    self.image = image;
}

+ (NSBundle *)wp_tableViewBundle
{
    static NSBundle *tableViewBundle = nil;
    if (nil == tableViewBundle) {
        //Default use `[NSBundle mainBundle]`.
        tableViewBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WPBaseTableView" ofType:@"bundle"]];
        if (nil == tableViewBundle) { // Empty description resource file in `PYSearch.framework`.
            tableViewBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(@"BaseSectionTableViewViewController")] pathForResource:@"WPBaseTableView" ofType:@"bundle"]];
        }
    }
    return tableViewBundle;
}
@end
