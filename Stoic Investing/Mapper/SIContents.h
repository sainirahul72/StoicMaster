//
//  SIContents.h
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIContents : NSObject
@property (nonatomic, assign) NSString *filename;
@property (nonatomic, assign) NSString *fileurl;
@property (nonatomic, assign) NSString *player_time;
@property (nonatomic, assign) NSString *duration;
-(SIContents*)mapResponse:(NSDictionary*)contents;
@end
