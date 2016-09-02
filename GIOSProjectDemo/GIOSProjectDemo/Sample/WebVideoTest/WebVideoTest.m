//
//  WebVideoTest.m
//  GIOSProjectDemo
//
//  Created by liufuyin on 16/9/2.
//  Copyright © 2016年 liufuyin. All rights reserved.
//

#import "CommonDefine.h"
#import "WebVideoTest.h"
#import <WebKit/WebKit.h>

@interface WebVideoTest()

@property(nonatomic, strong) UIWebView *webview;
@property(nonatomic, strong) WKWebView *wkWebview;

@end

@implementation WebVideoTest
- (void)viewDidLoad
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"样式列表";
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
    [btn setTitle:@"请求" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(startRequest) forControlEvents:UIControlEventTouchUpInside];
    
}

-(NSString*)resPathLocalWithName:(NSString*)name type:(NSString*)type
{
    NSString* bundlePath = [NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle] pathForResource:name ofType:type]];
    return bundlePath;
}

-(NSString*)reUrlWithType:(NSString*)type
{
    if ([type isEqualToString:@"mp4"]) {
         return  @"http://www.w3school.com.cn/example/html5/mov_bbb.mp4";
    }
    if ([type isEqualToString:@"gif"]) {
        return  @"http://ww1.sinaimg.cn/large/85cccab3tw1esjw3dyui5g209q0bk1kx.jpg";
    }
    return nil;
}

-(NSString*)htmlStrWithResUrl:(NSString*)resUrl resType:(NSString*)type
{
    if ([type isEqualToString:@"mp4"])
    {
        return [NSString stringWithFormat:@"<html><body style=\"margin:0;padding:0;background-color:transparent;\" onload=\"javascript:document.getElementById('videoTest').play();\" ><video id=\"videoTest\" controls=\"controls\"  width='100%%' height='100%%' webkit-playsinline=\"true\"><source src=\"%@\" type=\"video/mp4\" />Your browser does not support HTML5 video.</video></body></html>",resUrl];
    }
    if ([type isEqualToString:@"gif"]) {
        return  @"http://ww1.sinaimg.cn/large/85cccab3tw1esjw3dyui5g209q0bk1kx.jpg";
    }
    return nil;
}


-(void)creatUIWebViewVideo
{
    if (_webview.superview) {
        [_webview removeFromSuperview];
    }
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320, 200)];
    [self.view addSubview:_webview];
    
    NSString *localResPath = [self resPathLocalWithName:@"advideo" type:@"mp4"];
    
    NSString *html =  [self htmlStrWithResUrl:localResPath resType:@"mp4"];
    _webview.allowsInlineMediaPlayback = YES;
    _webview.mediaPlaybackRequiresUserAction = NO;
    [_webview loadHTMLString:html baseURL:nil];
    
}



-(void)creatWKWebViewVideo
{
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.mediaPlaybackRequiresUserAction = NO;
    config.allowsInlineMediaPlayback = YES;
    config.preferences = [WKPreferences new];
    _wkWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 290, 320, 200) configuration:config];
    [self.view addSubview:_wkWebview];
    
     NSString *localResPath = [self reUrlWithType:@"mp4"];
    NSString *wkhtml =  [self htmlStrWithResUrl:localResPath resType:@"mp4"];
    
    [_wkWebview loadHTMLString:wkhtml baseURL:nil];
}


-(void)startRequest
{
//    [self creatUIWebViewVideo];
    [self creatWKWebViewVideo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
