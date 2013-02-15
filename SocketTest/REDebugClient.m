//
//  REDebugClient.m
//  SocketTest
//
//  Created by Roman Efimov on 2/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REDebugClient.h"

void RELogConnect()
{
    [[REDebugClient sharedClient] connect];
}

void RELogClear()
{
    [[REDebugClient sharedClient] sendClear];
}

void RELog(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    NSString *log = [[NSString alloc] initWithFormat:message arguments:args];
    [[REDebugClient sharedClient] sendMessage:log];
}

void RELogInfo(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    NSString *log = [[NSString alloc] initWithFormat:message arguments:args];
    [[REDebugClient sharedClient] sendInfo:log];
}

void RELogWarning(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    NSString *log = [[NSString alloc] initWithFormat:message arguments:args];
    [[REDebugClient sharedClient] sendWarning:log];
}

void RELogError(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    NSString *log = [[NSString alloc] initWithFormat:message arguments:args];
    [[REDebugClient sharedClient] sendError:log];
}

@implementation REDebugClient

void test(NSString *message, ...)
{
    
}

+ (REDebugClient *)sharedClient
{
    static REDebugClient *sharedClient;
    
    @synchronized(self)
    {
        if (!sharedClient)
            sharedClient = [[REDebugClient alloc] init];
        return sharedClient;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)connectToHost:(NSString *)host post:(uint16_t)port
{
    NSError *error = nil;
    if (![_asyncSocket connectToHost:host onPort:port error:&error]) {
        NSLog(@"Error connecting: %@", error);
    }
}

- (void)connect
{
    [self connectToHost:@"localhost" post:9000];
}

- (void)sendMessage:(NSString *)message level:(NSInteger)level
{
    NSDictionary *info = @{
                           @"method": @2,
                           @"content": @{
                               @"level": @(level),
                               @"message": [NSString stringWithFormat:@"[%@] %@", [NSDate date], message]
    }};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
    NSString *jsonString = [NSString stringWithFormat:@"%@\n", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	[_asyncSocket writeData:data withTimeout:0 tag:0];
}

- (void)sendClear
{
    NSDictionary *info = @{@"method": @1};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
    NSString *jsonString = [NSString stringWithFormat:@"%@\n", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
	[_asyncSocket writeData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:0 tag:0];
}

- (void)sendMessage:(NSString *)message
{
    [self sendMessage:message level:REDebugClientMessageNone];
}

- (void)sendInfo:(NSString *)message
{
    [self sendMessage:message level:REDebugClientMessageInfo];
}

- (void)sendWarning:(NSString *)message
{
    [self sendMessage:message level:REDebugClientMessageWarning];
}

- (void)sendError:(NSString *)message
{
    [self sendMessage:message level:REDebugClientMessageError];
}

@end
