//
//  SIModules.m
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "SIModules.h"
#import "SIContents.h"

@implementation SIModules
-(SIModules*)mapResponse:(NSDictionary*)module{
    self.url = module[@"url"];
    self.name = module[@"name"];
    self.modicon = module[@"modicon"];
    self.summary = module[@"summary"];
    self.contents = [NSMutableArray array];
    for (int i=0; i<[module[@"contents"] count]; i++) {
        [self.contents addObject:[[[SIContents alloc]init] mapResponse:module[@"contents"]]];
    }
    return self;
}
@end
