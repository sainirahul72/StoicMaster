//
//  NSDictionary+UrlEncoding.m
//  Stoic Investing
//
//  Created by Rahul Saini on 16/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "NSDictionary+UrlEncoding.h"
@implementation NSDictionary (UrlEncoding)

+(NSString *)urlEncode:(id)object{
    NSString *string = [object description];
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)string,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]~.",
                                                                                                    kCFStringEncodingUTF8 ));
    return encodedString;
}

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = self[key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", [NSDictionary urlEncode:key], [NSDictionary urlEncode:value]];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

@end
