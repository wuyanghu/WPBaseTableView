//
//  BaseNetWorkConfig.h
//  WPBase
//
//  Created by wupeng on 2019/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPBaseNetWorkConfig : NSObject
@property (nonatomic,assign) BOOL isSVProgressHUD;//是否加载圈圈，默认加载
@property (nonatomic,assign) BOOL isAlertError;//网络错误是否提示
@property (nonatomic,copy) NSString * urlString;//请求url
@property (nonatomic,strong) NSMutableDictionary * headersParams;
@property (nonatomic,strong) NSMutableDictionary * bodyParams;
- (instancetype)initWithAction:(NSString *)action encryptKey:(NSString *)encryptKey;
@end

@interface WPBaseNetWorkModel : NSObject
@property (nonatomic,copy) NSString * message;
@property (nonatomic,copy) NSString * result;
@property (nonatomic,copy) NSString * code;

- (NSDictionary *)dictFromResult;
@end
NS_ASSUME_NONNULL_END


