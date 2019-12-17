//
//  NSObject+swizzle.h
//  CMRead-iPhone
//
//  Created by yrl on 17/3/30.
//  Copyright © 2017年 CMRead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel;
@end
