//
//  NSString+MD5Encrypt.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/16.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "NSString+MD5Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Encrypt)
#pragma mark - 32位 小写
- (NSString *)MD5ForLower32Bate{
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
@end
