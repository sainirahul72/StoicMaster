//
//  SIModules.h
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIModules : NSObject
@property (nonatomic, assign) NSString *url;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *modicon;
@property (nonatomic, assign) NSString *summary;
@property (nonatomic, assign) NSMutableArray *contents;
-(SIModules*)mapResponse:(NSDictionary*)module;
@end
