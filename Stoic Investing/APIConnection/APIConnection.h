//
//  APIConnection.h
//  Stoic Investing
//
//  Created by Rahul Saini on 17/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConnection : NSObject
-(NSURLSessionTask * _Nonnull)startDataTaskForDomainwithURLPathComponent:(NSString * _Nonnull)urlPathComponent postJSONParameters:(NSDictionary * _Nullable)postParams getJSONParameters:(NSDictionary * _Nullable)getParams completionHandler:(void (^ _Nonnull)(NSError * _Nullable error, id _Nullable response))completionHandler;
@end
