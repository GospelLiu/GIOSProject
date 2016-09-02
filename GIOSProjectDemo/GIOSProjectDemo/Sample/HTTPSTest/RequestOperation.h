//
//  (GIOS)RequestOperation.h
//  GIOSProjectDemo
//
//  Created by liufuyin on 16/8/5.
//  Copyright © 2016年 liufuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HTTPSTest.h"

@interface  RequestOperation : NSOperation
@property(nonatomic, strong)HTTPSTest *httpsTestObj;

typedef void (^RequestCompletionHandler)(NSHTTPURLResponse *response, NSDictionary *stats, NSString *responseDic, NSError *error);

-(id)initWithRequest:(NSURLRequest*)request completionHandler:(RequestCompletionHandler)completionHandler;

 
@end
