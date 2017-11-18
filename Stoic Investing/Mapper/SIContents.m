//
//  SIContents.m
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "SIContents.h"

@implementation SIContents
-(SIContents*)mapResponse:(NSDictionary*)contents{
    self.filename = contents[@"filename"];
    self.fileurl = contents[@"fileurl"];
    self.duration = contents[@"duration"];
    self.player_time = contents[@"player_time"];
    return self;
}
@end
