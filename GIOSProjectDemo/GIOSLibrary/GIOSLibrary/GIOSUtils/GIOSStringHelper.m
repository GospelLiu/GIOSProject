//
//  GIOSStringHelper.m
//  GIOSLibrary
//
//  Created by liufuyin on 15/9/24.
//  Copyright © 2015年 liufuyin. All rights reserved.
//

#import "GIOSStringHelper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GIOS(StringHelper)

+(NSString*)getMD5HashWithString:(NSString*)sourceString
{
    const char *cStr = [sourceString UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+(NSString*)getSHA1HashWithString:(NSString*)sourceString
{
    const char *cstr = [sourceString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:sourceString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
