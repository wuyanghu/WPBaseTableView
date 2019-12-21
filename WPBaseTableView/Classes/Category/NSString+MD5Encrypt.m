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

#pragma mark - MD5加密算法
- (NSString *)md5EncodeWithEncodeType:(MD5EncodeType)encodeType
{
    if (self.length > 0)
    {
        const char *cStr = [self UTF8String];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        switch (encodeType)
        {
            case MD5EncodeType16Lowercase:
            case MD5EncodeType32Lowercase:
                for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
                {
                    [output appendFormat:@"%02x", digest[i]];
                }
                break;
            case MD5EncodeType16Capital:
            case MD5EncodeType32Capital:
                for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
                {
                    [output appendFormat:@"%02X", digest[i]];
                }
                break;
                
            default:
                break;
        }
        
        NSString *result = output;
        
        if (MD5EncodeType16Lowercase == encodeType || MD5EncodeType16Capital == encodeType)
        {
            // 16位取的是32位字符串中间16位
            result = [output substringWithRange:NSMakeRange(8, 16)];
        }
        return result;
    }
    return nil;
}

@end
