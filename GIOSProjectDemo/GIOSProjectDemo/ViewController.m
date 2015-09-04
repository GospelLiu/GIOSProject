//
//  ViewController.m
//  GIOSProjectDemo
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import "ViewController.h"
#import "GIOSKit.h"

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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"18701433104"]]];
}
@end
