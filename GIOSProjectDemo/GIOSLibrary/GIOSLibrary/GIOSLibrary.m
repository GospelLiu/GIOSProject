//
//  GIOSLibrary.m
//  GIOSLibrary
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import "GIOSLibrary.h"

@implementation GIOS(Library)

+(void)TestLogA
{
    NSString *className = NSStringFromClass( [self class]);
    NSLog(@"gospel :%@",className);
}


@end
