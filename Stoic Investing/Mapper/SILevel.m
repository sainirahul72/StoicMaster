//
//  SILevel.m
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "SILevel.h"
#import "SIModules.h"

@implementation SILevel
-(SILevel*)mapResponse:(NSDictionary*)level{
    self.name = level[@"name"];
    self.summary = level[@"summary"];
    self.modules = [NSMutableArray array];
    for (int i=0; i<[level[@"modules"] count]; i++) {
        [self.modules addObject:[[[SIModules alloc]init] mapResponse:level[@"modules"]]];
    }
    return self;
}
@end
