//
//  AppDelegate.h
//  Stoic Investing
//
//  Created by Rahul Saini on 16/11/17.
//  Copyright © 2017 Stoic Investing. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;


@end

