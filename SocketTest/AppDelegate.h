//
//  AppDelegate.h
//  SocketTest
//
//  Created by Roman Efimov on 2/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#import "JSONKit.h"
#import "REDebugClient.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GCDAsyncSocketDelegate> {
    GCDAsyncSocket *asyncSocket;
}

@property (strong, nonatomic) UIWindow *window;

@end
