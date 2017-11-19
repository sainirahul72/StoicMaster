//
//  APIConnection.m
//  Stoic Investing
//
//  Created by Rahul Saini on 17/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "APIConnection.h"
#import "NSDictionary+UrlEncoding.h"

#define WeakSelf __typeof(self) __weak weakSelf = self;
#define BlockSelf __typeof(weakSelf) __weak blockSelf = weakSelf;

@interface APIConnection()<NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSessionConfiguration * sessionConfig;
@property (nonatomic, strong) NSURLSession * session;
@end

@implementation APIConnection

-(instancetype)init {
    self = [super init];
    self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionConfig.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    self.sessionConfig.timeoutIntervalForRequest = 240;
    self.sessionConfig.timeoutIntervalForResource = 240;
    self.sessionConfig.networkServiceType = NSURLNetworkServiceTypeDefault;
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    return self;
}

-(NSURLSessionTask * _Nonnull)startDataTaskForDomainwithURLPathComponent:(NSString * _Nonnull)urlPathComponent postJSONParameters:(NSDictionary * _Nullable)postParams getJSONParameters:(NSDictionary * _Nullable)getParams completionHandler:(void (^ _Nonnull)(NSError * _Nullable error, id _Nullable response))completionHandler {
    
    NSMutableDictionary * getParamsCopy;
    if(getParams) {
        getParamsCopy = getParams.mutableCopy;
    } else {
        getParamsCopy = [NSMutableDictionary dictionary];
    }
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlPathComponent]];
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, getParamsCopy.urlEncodedString]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:240];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    NSMutableDictionary * postParamsCopy;
    if(postParams) {
        postParamsCopy = postParams.mutableCopy;
    } else {
        postParamsCopy = [NSMutableDictionary dictionary];
    }
    WeakSelf
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:postParamsCopy options:0 error:nil];
    [request setHTTPBody:httpBody];
    
    NSString* myString;
    myString = [[NSString alloc] initWithData:httpBody encoding:NSASCIIStringEncoding];
    NSLog(@"Request Started: %@ params:%@", request, myString);
    NSURLSessionTask * task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BlockSelf
        [blockSelf handleResponseData:data urlResponse:response forRequest:request apiError:error completionHandler:completionHandler];
    }];
    
    [task resume];
    return task;
}

-(void)handleResponseData:(NSData *)responseData urlResponse:(NSURLResponse *)response forRequest:(NSURLRequest *)request apiError:(NSError *)apiError completionHandler:(void (^)(NSError *, id))completionHandler {
    
    NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse *)response;
    if(apiError || httpResponse.statusCode != 200 ) {
        if(apiError.code == NSURLErrorCancelled ) {
            NSLog(@"Request Cancelled: %@", request);
            return;
        } else if ( httpResponse.statusCode != 200 && apiError == nil) {
            NSLog(@"some error from server when request %@",request);
            apiError = [NSError errorWithDomain:@"Request Cancelled" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey:@"Connection could not be established. Please try again later!"}];
        }
        
        NSLog(@"Request Failed With Error: %@\n Error:%@", request, apiError);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completionHandler) completionHandler(apiError, nil);
        });
        
        return;
    }
    
    NSError * err;
    id res;
    if([response.MIMEType.lowercaseString isEqualToString:@"application/json"]) {
        res = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
        if (!res) {
            NSString* string =  [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
            NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
            err = nil;
            res = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingMutableContainers
                                                    error:&err];
        }
        NSLog(@"Request Complete: %@\nResponse:%@", request, [res stringValue]);
    } else {
        res = responseData;
        NSLog(@"Request Complete: %@\nResponse:%@", request, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        if(completionHandler) completionHandler(nil, res);
        return;
    }
    
    if(err) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completionHandler) completionHandler(err, nil);
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            /* need to remove it later, res[@"resCode"] should come in as number */
            if([res[@"resCode"] isKindOfClass:[NSNumber class]] && [res[@"resCode"] isEqualToNumber:@200]) {
                if(completionHandler) completionHandler(nil, res);
            }else if ([res[@"resCode"] isKindOfClass:[NSString class]] && [res[@"resCode"] isEqualToString:@"200"]){
                if(completionHandler) completionHandler(nil, res);
            } else {
                NSError * error = [NSError errorWithDomain:@"APIErrorDomain" code:[res[@"resCode"] integerValue] userInfo:@{@"resMessage": res[@"resMessage"]?res[@"resMessage"]: @"",@"response":res[@"response"]?res[@"response"]:@{}}];
                if(completionHandler) completionHandler(error, res);
            }
        });
    }
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

@end
