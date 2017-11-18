//
//  SICources.h
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SICources : NSObject
@property (nonatomic, assign) NSString *shortname;
@property (nonatomic, assign) NSString *fullname;
@property (nonatomic, assign) NSString *summary;
@property (nonatomic, assign) NSMutableArray *level;
-(SICources*)mapResponse:(NSDictionary*)cource;
@end
