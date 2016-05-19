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


#define object_validate(object, default_value) ((object) == nil ? (default_value) : (object))

@interface ViewController ()
{
}

@property(nonatomic,strong)NSTimer *testTimer;
@property(nonatomic)NSDate *mDateBegin;
@property(nonatomic)NSTimeInterval mTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, 0, 0);
    UIView *view = [[UIView alloc] initWithFrame:rect];
 
}

-(void)creatBannerView
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"adfa");
    
}

@end
