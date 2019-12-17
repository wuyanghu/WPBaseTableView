//
//  UpLoadJsonAPI.m
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import "WPRequestVCJsonAPI.h"
#import "NSObject+Json.h"

@implementation WPRequestVCJsonAPI

- (void)queryAllClassNameWithblock:(BaseNetWorkAPICallBlock)block{
    WPBaseNetWorkConfig * config = [WPBaseNetWorkConfig new];
    config.isSVProgressHUD = YES;
    config.urlString = [config.urlString stringByAppendingString:@"QueryAllServlet"];
    [config.headersParams setValuesForKeysWithDictionary:@{@"Action":@"QueryAllClassNameServlet"}];
    [self requestWithConfig:config block:block];
}

- (void)queryClassNameDetailInfoWithClassName:(NSString *)classname block:(BaseNetWorkAPICallBlock)block{
    WPBaseNetWorkConfig * config = [WPBaseNetWorkConfig new];
    config.isSVProgressHUD = NO;
    config.urlString = [config.urlString stringByAppendingString:@"QueryAllServlet"];
    
    [config.headersParams setValuesForKeysWithDictionary:@{@"Action":@"QueryAllServlet"}];
    [config.bodyParams setValuesForKeysWithDictionary:@{@"classname":classname}];
    
    [self requestWithConfig:config block:block];
}

- (void)upLoadJsonToServerWithFileName:(NSString *)fileName block:(BaseNetWorkAPICallBlock)block{
    NSMutableDictionary * bodyParams = [self getUploadBodyParams:fileName];
    WPBaseNetWorkConfig * config = [self getUploadConfig];
    [config.headersParams setValuesForKeysWithDictionary:@{@"Action":@"UploadJsonDBServlet"}];
    [config.bodyParams setValuesForKeysWithDictionary:bodyParams];
    [self requestWithConfig:config block:block];
}

- (NSMutableDictionary *)getUploadBodyParams:(NSString * _Nonnull)fileName{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    if (!strPath) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:strPath];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary * bodyParams = [NSMutableDictionary dictionaryWithDictionary:dict];
    [bodyParams setObject:fileName forKey:@"classname"];
    [bodyParams setObject:[self md5String:data] forKey:@"md5String"];
    
    return bodyParams;
}

- (WPBaseNetWorkConfig *)getUploadConfig{
    WPBaseNetWorkConfig * config = [WPBaseNetWorkConfig new];
    config.isSVProgressHUD = NO;
    config.urlString = [config.urlString stringByAppendingString:@"UploadJsonDBServlet"];
    
    return config;
}

@end


