//
//  BaseNetWorkConfig.m
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import "WPBaseNetWorkConfig.h"
#import "NSObject+Json.h"
#define kWPRequestUrl @"kWPRequestUrl"

@implementation WPBaseNetWorkConfig

- (instancetype)init{
    self = [super init];
    if(self){
        _isSVProgressHUD = YES;
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        _urlString = [userDefaults objectForKey:@"WPConfigUrl"];
        _isAlertError = YES;
    }
    return self;
}

#pragma mark - getter

- (NSMutableDictionary *)headersParams{
    if (!_headersParams) {
        _headersParams = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _headersParams;
}

- (NSMutableDictionary *)bodyParams{
    if (!_bodyParams) {
        _bodyParams = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _bodyParams;
}

@end

@implementation WPBaseNetWorkModel

- (NSDictionary *)dictFromResult{
    NSDictionary * resultDict;
    if (self.result.length>0) {
        resultDict = [self dictionaryWithJsonString:self.result];
    }
    return resultDict;
}

@end




