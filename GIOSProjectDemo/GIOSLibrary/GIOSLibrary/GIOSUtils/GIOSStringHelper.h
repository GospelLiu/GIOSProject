//
//  GIOSStringHelper.h
//  GIOSLibrary
//
//  Created by liufuyin on 15/9/24.
//  Copyright © 2015年 liufuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIOSDefine.h"

@interface GIOS(StringHelper) : NSObject

+(NSString*)getMD5HashWithString:(NSString*)sourceString;
+(NSString*)getSHA1HashWithString:(NSString*)sourceString;

@end
