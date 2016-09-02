//
//  TestLibA.m
//  TestLibA
//
//  Created by liufuyin on 16/8/13.
//  Copyright © 2016年 liufuyin. All rights reserved.
//

#import "TestLibA.h"
//#import "GIOSLibrary.h" 
//#import <UTDID/UTDevice.h>
#import <GIOSFramework/GIOSLibrary.h>
//#import <MMUFoundation/MMUWebViewController.h>

@implementation TestLibA



-(void)testInfo
{
    [GIOS(Library)  TestLogA];
//    [UTDevice utdid];
    
//    UIViewController *a = [[MMUWebViewController alloc] initWithUrl:@"http://www.baidu.com"];
}

@end
