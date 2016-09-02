//
//  (GIOS)RequestOperation.m
//  GIOSProjectDemo
//
//  Created by liufuyin on 16/8/5.
//  Copyright © 2016年 liufuyin. All rights reserved.
//

#import <Security/Security.h>
#import "RequestOperation.h"


@interface RequestOperation() 
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSURLResponse *response;
@property(nonatomic, strong) NSURLRequest *request;
@property(nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, copy)  RequestCompletionHandler completionHandler;
@property (nonatomic,assign)  BOOL isDone;
@end


@implementation RequestOperation

@synthesize finished = _finished, executing = _executing;



-(id)initWithRequest:(NSURLRequest*)request completionHandler:(RequestCompletionHandler)completionHandler;
{
    self = [super init];
    if (self)
    {
        _request = request;
        _responseData = [[NSMutableData alloc] init];
        
        if (completionHandler)
        {
            self.completionHandler = completionHandler;
        }
        
    }
    
    return self;
}

-(void)start
{
    @autoreleasepool {
        self.executing = YES;
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
        _isDone = NO;
        while (self.connection && !_isDone) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }

}

- (void)cancel
{
    [super cancel];
    
    if (self.connection)
    {
        [self.connection cancel];
        
    }
    _connection = nil;
    self.executing = NO;
}



- (void)reset
{
    self.connection = nil;
}


- (BOOL)isConcurrent
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
 
    
    if (![response respondsToSelector:@selector(statusCode)] || [((NSHTTPURLResponse *)response) statusCode] < 400)
    {
        self.response = response;
    }
    else
    {
        [self.connection cancel];
    }
    
}
//
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}


-(OSStatus) extractP12Data:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity
{
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("the_password");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    if (options) {
        CFRelease(options);
    }
    return securityError;
}

//回调
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//
//    /*
//    NSString *method = challenge.protectionSpace.authenticationMethod;
//    NSLog(@"%@", method);
//    if([method isEqualToString:NSURLAuthenticationMethodServerTrust]){
//        NSString *host = challenge.
//        protectionSpace.host;
//        NSLog(@"%@", host);
//        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
////        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//        return;
//    }
//    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
//    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
//    CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
//    SecIdentityRef identity;
//    // 读取p12证书中的内容
//    OSStatus result = [self extractP12Data:inPKCS12Data toIdentity:&identity];
//    if(result != errSecSuccess){
////        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//        return;
//    }
//    SecCertificateRef certificate = NULL;
//    SecIdentityCopyCertificate (identity, &certificate);
//    const void *certs[] = {certificate};
//    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
//    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:(NSArray*)CFBridgingRelease(certArray) persistence:NSURLCredentialPersistencePermanent];
////    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//    */
//    
//    
//    //1)获取trust object
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    SecTrustResultType result;
    
    //注意：这里将之前导入的证书设置成下面验证的Trust Object的anchor certificate
    SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef)self.httpsTestObj.trustedCertificates);
    //2)SecTrustEvaluate会查找前面SecTrustSetAnchorCertificates设置的证书或者系统默认提供的证书，对trust进行验证
    OSStatus status = SecTrustEvaluate(trust, &result);
    if (status == errSecSuccess &&
        (result == kSecTrustResultProceed ||
         result == kSecTrustResultUnspecified)) {
            
            //3)验证成功，生成NSURLCredential凭证cred，告知challenge的sender使用这个凭证来继续连接
            NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
            [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
            
        } else {
            
            //5)验证失败，取消这次验证流程
            [challenge.sender cancelAuthenticationChallenge:challenge];
            
        }
}

//
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        //if ([trustedHosts containsObject:challenge.protectionSpace.host])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSInteger statusCode = [(NSHTTPURLResponse *)self.response statusCode];
    if (statusCode >= 200 && statusCode < 400)
    {
        NSString *responseInStr = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        if (self.completionHandler)
        {
            self.completionHandler((NSHTTPURLResponse *)self.response,nil, responseInStr, nil);
        }
    }
    [self setFinished:YES];
    [self setExecuting:NO];
    _isDone = YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if (self.completionHandler)
    {
        self.completionHandler((NSHTTPURLResponse *)self.response, nil, nil, error);
    }
    
    [self setFinished:YES];
    [self setExecuting:NO];
    _isDone = YES;
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
    
}


- (void)dealloc {
    
    self.request = nil;
    self.response = nil;
    self.responseData = nil;
    self.connection = nil;
    self.completionHandler = nil;
}

@end
