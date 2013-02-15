//
//  REDebugClient.m
//  SocketTest
//
//  Created by Roman Efimov on 2/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REDebugClient.h"

void RELogConnect(NSString *host, uint16_t port)
{
    [[REDebugClient sharedClient] connectToHost:host post:port];
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

- (void)writeDictionary:(NSDictionary *)dictionary
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    NSString *jsonString = [NSString stringWithFormat:@"%@\n", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [_asyncSocket writeData:data withTimeout:0 tag:0];
}

- (void)sendMessage:(NSString *)message level:(NSInteger)level
{
    
    NSDate *date = 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval milisecondedDate = ([[NSDate date] timeIntervalSince1970] * 1000);
    
    NSLog(@"%@.%f", [formatter stringFromDate:[NSDate date]], milisecondedDate);
    
    NSDictionary *info = @{
                           @"method": @2,
                           @"content": @{
                               @"level": @(level),
                               @"message": [NSString stringWithFormat:@"[%@] %@", [NSDate date], message]
    }};
    
    [self writeDictionary:info];
}

- (void)sendClear
{
    [self writeDictionary:@{@"method": @1}];
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
