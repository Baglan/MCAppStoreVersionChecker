# MCAppStoreVersionChecker

Fetch a version on a currently published on iTunes AppStore app to compare with the version of the running app.

Presumably it's the same app and, by comparing versions, one can tell if updated version is in the AppStore.

## Installation

Copy the files in the 'Classes' folder into your project.

## Usage

Recommended pattern is as following:

Add initilization and update code in AppDelegate

```
#import "MCAppStoreVersionChecker.h"

...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [MCAppStoreVersionChecker sharedInstance].appID = @"766214869";
    
    return YES;
}

...

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[MCAppStoreVersionChecker sharedInstance] update];
}

```

Subscribe to the notification and handle updates in a view controller

```
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
```


## License

All the code in this project is available under the MIT license.