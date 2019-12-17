//
//  UIView+Masonry.m
//  WPBase
//
//  Created by wupeng on 2019/11/13.
//

#import "UIView+Masonry.h"
#import "Masonry.h"

@implementation UIView (Masonry)

//获取约束的值
- (CGFloat)getOffsetWithAttribute:(NSLayoutAttribute)attribute{
    NSArray *installedConstraints = [MASViewConstraint installedConstraintsForView:self];
    for (MASViewConstraint * constraint in installedConstraints) {
        MASViewAttribute * firstViewAttribute = constraint.firstViewAttribute;
        if (firstViewAttribute.layoutAttribute == attribute) {
            CGFloat offset = [[constraint valueForKey:@"layoutConstant"] floatValue];
            return offset;
        }
    }
    return 0;
}

@end
