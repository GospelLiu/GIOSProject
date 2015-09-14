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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [GIOSLibrary TestLogA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn  addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)test
{
    NSString *str = @"http://www.baidu.com";

    
    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
        NSInteger resultStr = [str hash];
    
    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
     NSLog(@"%li",(long)resultStr);
    
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    
    NSLog(@"%@",output);
}
@end
