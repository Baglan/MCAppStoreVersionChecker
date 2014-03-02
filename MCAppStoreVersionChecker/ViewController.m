//
//  ViewController.m
//  MCAppStoreVersionChecker
//
//  Created by Baglan on 3/2/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "ViewController.h"
#import "MCAppStoreVersionChecker.h"

@interface ViewController ()

@end

@implementation ViewController {
    __weak IBOutlet UILabel *_versionLabel;
    __weak IBOutlet UILabel *_higherLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVersionInfo) name:MCAppStoreVersionCheckerUpdatedNotification object:nil];
}

- (void)updateVersionInfo
{
    MCAppStoreVersionChecker * checker = [MCAppStoreVersionChecker sharedInstance];
    if (checker.version) {
        _versionLabel.text = checker.version;
        _higherLabel.text = [checker versionIsHigherThanThisAppsVersion] ? @"YES" : @"NO";
    }
}

@end
