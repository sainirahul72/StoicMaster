//
//  SIResponse.m
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "SIResponse.h"
#import "SICources.h"

@implementation SIResponse

-(SIResponse*)mapResponse:(NSDictionary*)response{
    self.category_id = response[@"category_id"];
    self.category_name = response[@"category_name"];
    self.category_description = response[@"category_description"];
    self.enrolled_course = [NSMutableArray array];
    for (int i=0; i<[response[@"enrolled_course"] count]; i++) {
        [self.enrolled_course addObject:[[[SICources alloc]init] mapResponse:response[@"enrolled_course"]]];
    }
    return self;
}

@end
