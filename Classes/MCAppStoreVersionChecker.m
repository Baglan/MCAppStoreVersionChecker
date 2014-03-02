//
//  MCAppStoreVersionChecker.m
//  MCAppStoreVersionChecker
//
//  Created by Baglan on 3/2/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCAppStoreVersionChecker.h"

#define MCAppStoreVersionCheckerURLTemplate @"http://itunes.apple.com/lookup?id=%@"

@implementation MCAppStoreVersionChecker

// Singleton
// Taken from http://lukeredpath.co.uk/blog/a-note-on-objective-c-singletons.html
+ (instancetype)sharedInstance
{
    __strong static id _sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)setAppID:(NSString *)appID
{
    _appID = [appID copy];
    _version = nil;
}

- (void)update
{
    if (self.appID) {
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        [queue addOperationWithBlock:^{
            @try {
                NSURL * checkURL = [NSURL URLWithString:[NSString stringWithFormat:MCAppStoreVersionCheckerURLTemplate, self.appID]];
                NSData * data = [NSData dataWithContentsOfURL:checkURL];
                NSDictionary * lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray * results = lookup[@"results"];
                NSDictionary * app = [results lastObject];
                _version = app[@"version"];
                [[NSNotificationCenter defaultCenter] postNotificationName:MCAppStoreVersionCheckerUpdatedNotification object:self];
            }
            @catch (NSException *exception) {
                // Make sure app doesn't crash
            }
        }];
    }
}

- (BOOL)versionIsHigherThanThisAppsVersion
{
    NSString * thisAppsVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSComparisonResult result = [self.version compare:thisAppsVersion];
    return result == NSOrderedDescending;
}

@end
