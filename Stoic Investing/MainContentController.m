//
//  MainContentController.m
//  Stoic Investing
//
//  Created by Rahul Saini on 19/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "MainContentController.h"
#import "SIResponse.h"
@interface MainContentController ()
@property (strong) IBOutlet NSTableView *tableView;
@property (strong) SIResponse *response;
@end

@implementation MainContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* commonsPath = [[NSBundle mainBundle] pathForResource:@"response" ofType:@".json"];
    NSError *error;
    NSData *paxDetailsData = [NSData dataWithContentsOfFile:commonsPath];
    NSMutableArray *dummyPaxDictionary = [NSJSONSerialization JSONObjectWithData:paxDetailsData options:(NSJSONReadingMutableContainers) error:&error];
    [self.response mapResponse:dummyPaxDictionary[0]];
    NSLog(@"test");
    // Do view setup here.
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return 1;
}

@end
