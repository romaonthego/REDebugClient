//
// REDebugClient.m
// REDebugClient
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
        NSLog(@"REDebugClient - error connecting: %@", error);
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
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSDictionary *info = @{
                           @"method": @2,
                           @"content": @{
                               @"level": @(level),
                               @"message": [NSString stringWithFormat:@"[%@] %@", [formatter stringFromDate:date], message]
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
