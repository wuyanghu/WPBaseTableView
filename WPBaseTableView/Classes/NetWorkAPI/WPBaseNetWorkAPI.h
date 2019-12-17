//
//  BaseNetWorkAPI.h
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import <Foundation/Foundation.h>
#import "WPBaseNetWorkConfig.h"

typedef void(^BaseNetWorkAPICallBlock)(WPBaseNetWorkModel * __nullable responseObject,NSError * __nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseNetWorkAPI : NSObject
- (void)requestWithConfig:(WPBaseNetWorkConfig *)config block:(BaseNetWorkAPICallBlock)block;
@end

NS_ASSUME_NONNULL_END


