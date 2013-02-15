//
//  AppDelegate.m
//  REDebugClientExample
//
//  Created by Roman Efimov on 2/15/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "AppDelegate.h"
#import "REDebugClient.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RELogConnect(@"localhost", 9000);
    RELogClear();
    
    RELog(@"Default");
    RELogInfo(@"Info multi\nLine");
    RELogWarning(@"UIWindow: %@", self.window);
    RELogError(@"Error");
    
    NSDictionary *dictionary = @{@"test": @123,
                                 @"demo": @{@"foo": @"bar",
                                            @"var": @2}};
    
    RELog(@"NSDictionary: %@", dictionary);
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
