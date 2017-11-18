//
//  SIResponse.h
//  Stoic Investing
//
//  Created by Rahul Saini on 18/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SIResponse : NSObject
@property (nonatomic, assign) NSString *category_id;
@property (nonatomic, assign) NSString *category_name;
@property (nonatomic, assign) NSString *category_description;
@property (nonatomic, assign) NSMutableArray *enrolled_course;
-(SIResponse*)mapResponse:(NSDictionary*)response;
@end
