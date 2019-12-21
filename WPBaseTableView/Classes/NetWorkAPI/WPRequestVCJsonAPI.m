//
//  UpLoadJsonAPI.m
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import "WPRequestVCJsonAPI.h"
#import "NSObject+Json.h"

@implementation WPRequestVCJsonAPI

- (void)queryClassNameDetailInfoWithClassName:(NSString *)classname block:(BaseNetWorkAPICallBlock)block{
    WPBaseNetWorkConfig * config = [WPBaseNetWorkConfig new];
    config.isSVProgressHUD = NO;
    config.urlString = [config.urlString stringByAppendingString:@"QueryAllServlet"];
    
    [config.headersParams setValuesForKeysWithDictionary:@{@"Action":@"QueryAllServlet"}];
    [config.bodyParams setValuesForKeysWithDictionary:@{@"classname":classname}];
    
    [self requestWithConfig:config block:block];
}

@end


