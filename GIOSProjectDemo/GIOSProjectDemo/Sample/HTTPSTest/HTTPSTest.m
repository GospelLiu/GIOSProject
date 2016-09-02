//
//  HTTPSTest.m
//  GIOSProjectDemo
//
//  Created by liufuyin on 16/9/2.
//  Copyright © 2016年 liufuyin. All rights reserved.
//

#import "HTTPSTest.h"
#import <Security/Security.h>
#import "ViewController.h"
#import "RequestOperation.h"
#import "CommonDefine.h"

@interface HTTPSTest()

@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSURLResponse *response;
@property(nonatomic, strong) NSURLRequest *request;
@property(nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation HTTPSTest

- (void)viewDidLoad
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"样式列表";
    
    [super viewDidLoad];
    _operationQueue = [[NSOperationQueue alloc] init];
    [_operationQueue setMaxConcurrentOperationCount:2];
    
    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"CA-Cert" ofType:@"cer"]; //证书的路径
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)(cerData));
    self.trustedCertificates = @[CFBridgingRelease(certificate)];
    
}

-(void)viewDidAppear:(BOOL)animated
{
   
}

@end
