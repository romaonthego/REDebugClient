//
//  REDebugClient.h
//  SocketTest
//
//  Created by Roman Efimov on 2/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

void RELogConnect(NSString *host, uint16_t port);
void RELogClear();
void RELog(NSString *message, ...);
void RELogInfo(NSString *message, ...);
void RELogWarning(NSString *message, ...);
void RELogError(NSString *message, ...);

typedef enum _REDebugClientMessageType {
    REDebugClientMessageNone    = 0,
    REDebugClientMessageInfo    = 1,
    REDebugClientMessageWarning = 2,
    REDebugClientMessageError    = 3
} REDebugClientMessageType;

@interface REDebugClient : NSObject <GCDAsyncSocketDelegate> {
    NSMutableArray *_queue;
}

@property (strong, readonly, nonatomic) GCDAsyncSocket *asyncSocket;

+ (REDebugClient *)sharedClient;
- (void)connectToHost:(NSString *)host post:(uint16_t)port;
- (void)sendMessage:(NSString *)message;
- (void)sendInfo:(NSString *)message;
- (void)sendWarning:(NSString *)message;
- (void)sendError:(NSString *)message;
- (void)sendClear;

@end