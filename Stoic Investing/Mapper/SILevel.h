//
//  SILevel.h
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SILevel : NSObject
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *summary;
@property (nonatomic, assign) NSMutableArray *modules;
-(SILevel*)mapResponse:(NSDictionary*)level;
@end
