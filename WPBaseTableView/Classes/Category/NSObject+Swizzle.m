//
//  NSObject+swizzle.m
//  CMRead-iPhone
//
//  Created by yrl on 17/3/30.
//  Copyright © 2017年 CMRead. All rights reserved.
//

#import "NSObject+Swizzle.h"

@implementation NSObject (Swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel {
    Method originMethod = class_getInstanceMethod(self, originalSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

@end
