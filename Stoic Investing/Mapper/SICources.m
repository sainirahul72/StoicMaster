//
//  SICources.m
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "SICources.h"
#import "SILevel.h"

@implementation SICources
-(SICources*)mapResponse:(NSDictionary*)cource{
    self.shortname = cource[@"shortname"];
    self.fullname = cource[@"fullname"];
    self.summary = cource[@"summary"];
    self.level = [NSMutableArray array];
    for (int i=0; i<[cource[@"level"] count]; i++) {
        [self.level addObject:[[[SILevel alloc]init] mapResponse:cource[@"level"]]];
    }
    return self;
}
@end
