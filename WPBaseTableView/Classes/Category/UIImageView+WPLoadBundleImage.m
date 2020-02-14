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
    static NSBundle *searchBundle = nil;
    if (nil == searchBundle) {
        //Default use `[NSBundle mainBundle]`.
        searchBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WPBaseTableView" ofType:@"bundle"]];
        if (nil == searchBundle) { // Empty description resource file in `PYSearch.framework`.
            searchBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(@"BaseSectionTableViewViewController")] pathForResource:@"WPBaseTableView" ofType:@"bundle"]];
        }
    }
    return searchBundle;
}
@end
