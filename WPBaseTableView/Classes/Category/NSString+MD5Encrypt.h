//
//  NSString+MD5Encrypt.h
//  DataStructureDemo
//
//  Created by wupeng on 2019/11/16.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MD5EncodeType)
{
    MD5EncodeType16Lowercase,           // 16位小写
    MD5EncodeType16Capital,             // 16位大写
    MD5EncodeType32Lowercase,           // 32位小写
    MD5EncodeType32Capital,             // 32位大写
};

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5Encrypt)
- (NSString *)MD5ForLower32Bate;

/**
 *  @brief  MD5加密一段字符串
 *
 *  @param input      输入加密字符串
 *  @param encodeType 加密类型
 *
 *  @return MD5加密后的字符串
 */
- (NSString *)md5EncodeWithEncodeType:(MD5EncodeType)encodeType;

@end

NS_ASSUME_NONNULL_END
