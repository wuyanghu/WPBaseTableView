//
//  UpLoadJsonAPI.h
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import "WPBaseNetWorkAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface WPRequestVCJsonAPI : WPBaseNetWorkAPI
- (void)queryClassNameDetailInfoWithClassName:(NSString *)classname block:(BaseNetWorkAPICallBlock)block;
@end

NS_ASSUME_NONNULL_END

