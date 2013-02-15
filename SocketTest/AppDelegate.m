//
//  AppDelegate.m
//  SocketTest
//
//  Created by Roman Efimov on 2/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RELogConnect();
    

    RELogClear();
    RELogInfo(@"Info\nTest");
    RELogWarning(@"Test = %@", self.window);
    RELogError(@"Error");
    
    NSDictionary *test = @{@"test": @123, @"demo": @{@"yolo": @1, @"haha": @2}};
    
    RELog(@"Test %@", test);
    

    //RELogWarning(@"Warning");
    
   // [[DebugClient sharedClient] message:@"TEst 12312 Жопа3"];
    
   /*
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
	asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    
    NSLog(@"Connecting...");
    
    NSError *error = nil;
    if (![asyncSocket connectToHost:@"localhost" onPort:9000 error:&error])
    {
        NSLog(@"Error connecting: %@", error);
    }
    
    NSString *requestStr = @"{\"method\":2,\"content\":{\"level\":0,\"message\":\"test 123456\"}}";
	NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    
	[asyncSocket writeData:requestData withTimeout:-1.0 tag:0];*/
    
   // [DebugClient s];
    
    return YES;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    return;
	//{"method":2,"content":{"level":0,"message":"test"}}
    
    NSString *requestStr = @"{\"method\":2,\"content\":{\"level\":0,\"message\":\"test 123\"}}";
	NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    
	[asyncSocket writeData:requestData withTimeout:-1.0 tag:0];
}


@end
