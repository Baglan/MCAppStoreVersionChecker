//
//  MCAppStoreVersionChecker.h
//  MCAppStoreVersionChecker
//
//  Created by Baglan on 3/2/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MCAppStoreVersionCheckerUpdatedNotification @"MCAppStoreVersionCheckerUpdatedNotification"

@interface MCAppStoreVersionChecker : NSObject

@property (nonatomic, copy) NSString * appID;
@property (nonatomic, readonly) NSString * version;

+ (instancetype)sharedInstance;

- (void)update;
- (BOOL)versionIsHigherThanThisAppsVersion;

@end
