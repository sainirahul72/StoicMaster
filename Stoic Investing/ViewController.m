//
//  ViewController.m
//  Stoic Investing
//
//  Created by Rahul Saini on 16/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import "ViewController.h"
#import "APIConnection.h"

@interface APIConnection()
@property (nonatomic, strong) NSURLSessionTask * currentAPISessionTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)Login:(id)sender {
    
    NSMutableDictionary * getParams = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * postParams = [[NSMutableDictionary alloc]init];
    getParams[@"user"] = @"testtest";
    getParams[@"password"] = @"wW@9044472181";
    getParams[@"type"] = @"login";
    getParams[@"machineId"] = @"110011001100";
    
    postParams[@"Authtoken"] = @"8l45phQR7ZktSRFE7Z6CqRyETrlUaRv3";
    NSString * urlPath = @"ec2-13-126-140-65.ap-south-1.compute.amazonaws.com/stoic/api_app/routerpost.php";
    
    APIConnection * connection = [[APIConnection alloc] init];
    [connection startDataTaskForDomainwithURLPathComponent:urlPath postJSONParameters:postParams getJSONParameters:getParams completionHandler:^(NSError * _Nullable error, NSDictionary* _Nullable response) {
        if (!error) {
            if ([response[@"resCode"] isEqualToNumber:@200]) {
                
            }else{
                
            }
        }else{
            
        }
        NSLog(@"Error -> %@, Response -> %@", error, response);
    }];
}

@end
