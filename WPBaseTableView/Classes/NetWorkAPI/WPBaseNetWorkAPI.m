//
//  BaseNetWorkAPI.m
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import "WPBaseNetWorkAPI.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation WPBaseNetWorkAPI

- (void)requestWithConfig:(WPBaseNetWorkConfig *)config block:(BaseNetWorkAPICallBlock)block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //更改默认请求的发送请求的二进制数据为JSON格式的二进制更改默  认的序列化方式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 2.0;
    
    [config.headersParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    if (config.urlString.length == 0) {
        return;
    }
    
    if(config.isSVProgressHUD){
        [SVProgressHUD show];
    }
    
    [manager POST:config.urlString parameters:config.bodyParams progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (block) {
             if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                 WPBaseNetWorkModel * model = [WPBaseNetWorkModel new];
                 [model setValuesForKeysWithDictionary:responseObject];
                 block(model,nil);
             }else{
                 block(responseObject,nil);
             }
         }
         if(config.isSVProgressHUD){
             [SVProgressHUD dismiss];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if(config.isSVProgressHUD){
             [SVProgressHUD dismiss];
         }
         
         if (block) {
             block(nil,error);
         }
         
         if (config.isAlertError) {
             [SVProgressHUD showErrorWithStatus:@"网络错误"];
         }
     }];
}

@end





