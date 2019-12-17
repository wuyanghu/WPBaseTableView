//
//  NSObject+AddParams.m
//  WPBase
//
//  Created by wupeng on 2019/9/24.
//

#import "NSObject+AddParams.h"
#import <objc/runtime.h>

@implementation NSObject (AddParams)

- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, @"params", params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, @"params");
}

@end
