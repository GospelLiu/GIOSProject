//
//  AppDelegate.h
//  GIOSProjectDemo
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

void SignalHandler(int signal);
void HandleException(NSException *exception);
void SignalHandler1(int signal);
void HandleException1(NSException *exception);
void InstallUncaughtExceptionHandler(NSUncaughtExceptionHandler *handleExp,void (*handleSignal)(int));


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *viewController;

@end

