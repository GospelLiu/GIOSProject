//
//  ViewController.m
//  GIOSProjectDemo
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import "ViewController.h"
#import "GIOSKit.h"
#import <CommonCrypto/CommonDigest.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "AppDelegate.h"
 


@interface ViewController ()
{
}
@property(nonatomic,strong)UIWebView *mWebView;
@property(nonatomic,strong)NSDictionary *mTmp;
@property(nonatomic)BOOL mUICreated;

@end

@implementation ViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _mUICreated = NO;
    }
    return self;
}

- (void)viewDidLoad{
    
    NSUInteger a = 100;
    
    NSNumber *testNum = @(a);
    NSLog(@"%@",testNum);
}

-(void)viewDidAppear:(BOOL)animated
{
}

#pragma mark 点击下载


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end



