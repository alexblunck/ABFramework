//
//  ABBonjourServer.m
//  ABFramework
//
//  Created by Alexander Blunck on 5/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABBonjourServer.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define NETSERVICE_DOMAIN @"local."

#define INTERNAL_CLIENT_DID_CONNECT @"ABBonjourServer.clientDidConnect"

typedef enum {
    ABBonjourServerModeNone,
    ABBonjourServerModeServer,
    ABBonjourServerModeClient
} ABBonjourServerMode;

@interface ABBonjourServer () <NSNetServiceDelegate, NSNetServiceBrowserDelegate, NSStreamDelegate>
{
    ABBonjourServerMode _mode;
    
    //Server
    NSNetService *_serverNetService;
    
    //Client
    NSNetServiceBrowser *_netServiceBrowser;
    NSMutableArray *_foundServices;
    NSMutableArray *_resolvedServices;
    NSNetService *_connectedNetService;
    ABBonjourServerSearchBlock _searchBlock;
    
    //Socket / Streams
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    int _socketDescriptor;
}

@end

@implementation ABBonjourServer

#pragma mark - Initializer
-(id) init
{
    NSLog(@"ABBonjourServer: ERROR -> Either start Server or Client with dedicated initializers!");
    return nil;
}



#pragma mark - Server
+(id) startServerWithName:(NSString*)name
{
    return [[self alloc] initAndStartServerWithName:name];
}

-(id) initAndStartServerWithName:(NSString*)name
{
    self = [super init];
    if (self)
    {
        _mode = ABBonjourServerModeServer;
        
        //Setup Socket
        in_port_t port = [self setupSocket];
        
        //Setup NSNetService
        NSString *netServiceType = [NSString stringWithFormat:@"_%@._tcp.", [name lowercaseString]];
        
        _serverNetService = [[NSNetService alloc] initWithDomain:@"local." type:netServiceType name:name port:ntohs(port)];
        _serverNetService.delegate = self;
        
        if(_serverNetService)
        {
            [_serverNetService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            [_serverNetService publish];
        }
        else
        {
            NSLog(@"ABBonjourServer: ERROR -> NSNetService object couldn't be initialized!");
        }

    }
    return self;
}



#pragma mark - Client
+(id) startClientForServerWithName:(NSString*)name foundServers:(ABBonjourServerSearchBlock)block
{
    return [[self alloc] initAndStartClientForServerWithName:name foundServers:block];
}

-(id) initAndStartClientForServerWithName:(NSString*)name foundServers:(ABBonjourServerSearchBlock)block
{
    self = [super init];
    if (self)
    {
        _mode = ABBonjourServerModeClient;
        
        _foundServices = [NSMutableArray new];
        _resolvedServices = [NSMutableArray new];
        
        [self searchForServerWithName:name foundServers:block];
    }
    return self;
}

-(void) searchForServerWithName:(NSString*)name foundServers:(ABBonjourServerSearchBlock)block
{
    if (_searchBlock)
    {
        _searchBlock(nil);
        _searchBlock = nil;
    }
    
    _searchBlock = [block copy];
    
    NSString *netServiceType = [NSString stringWithFormat:@"_%@._tcp.", [name lowercaseString]];
    
    if (_netServiceBrowser)
    {
        [_netServiceBrowser stop];
        _netServiceBrowser = nil;
    }
    
    //Search for broadcasting NSNetService & wait for delegate response
    _netServiceBrowser = [NSNetServiceBrowser new];
    _netServiceBrowser.delegate = self;
    [_netServiceBrowser scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_netServiceBrowser searchForServicesOfType:netServiceType inDomain:NETSERVICE_DOMAIN];
}

-(void) connectToService:(NSNetService*)aNetService completion:(ABBonjourServerConnectBlock)block
{
    _connectedNetService = aNetService;
    
    //Hook up streams
    NSInputStream *iStream = nil;
    NSOutputStream *oStream = nil;
    
    if ([_connectedNetService getInputStream:&iStream outputStream:&oStream])
    {
        _inputStream = iStream;
        _outputStream = oStream;
        
        _inputStream.delegate = self;
        _outputStream.delegate = self;
        
        [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        [_inputStream open];
        [_outputStream open];
        
        //Stop searching
        [_netServiceBrowser stop];
        
        //Execute block
        if (block)
        {
            block(YES);
        }
        
        //Inform server of this client
        [self sendInternalMessage:INTERNAL_CLIENT_DID_CONNECT];
        
        NSLog(@"ABBonjourClient -> Established Connection (%@)", _connectedNetService.hostName);
    }
    else
    {
        if (block)
        {
            block(NO);
        }
        
        NSLog(@"ABBonjourClient ERROR -> Failed to aquire valid streams!");
    }
}

-(void) closeClientConnection
{
    if (!_connectedNetService) return;
    
    NSLog(@"ABBonjourClient -> Disconnecting from %@.", _connectedNetService.hostName);
    
    //Inform delegate
    if ([self.delegate respondsToSelector:@selector(bonjourServerClientWillDisconnect)])
    {
        [self.delegate bonjourServerClientWillDisconnect];
    }
    
    [_inputStream close];
    [_outputStream close];
    
    _inputStream = nil;
    _outputStream = nil;
    
    
}



#pragma mark - Exchange Data
-(void) sendDictionary:(NSDictionary*)dic
{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    #ifdef ABFRAMEWORK_IOS
    [sendDic setObject:[[UIDevice currentDevice] name] forKey:@"senderDeviceName"];
    #endif
    #ifdef ABFRAMEWORK_MAC
    [sendDic setObject:[[NSHost currentHost] localizedName] forKey:@"senderDeviceName"];
    #endif
    
    [sendDic setObject:[[NSProcessInfo processInfo] hostName] forKey:@"senderHostName"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sendDic];
    
    [_outputStream write:[data bytes] maxLength:[data length]];
}

-(void) sendInternalMessage:(NSString*)message
{
    [self sendDictionary:@{@"internalMessage": message}];
}



#pragma mark - Process Data
-(void) inputStreamHasData:(NSInputStream*)inputStream
{
    int bytesRead = 0;
    NSMutableData *data = [NSMutableData new];
    uint8_t buf[1024];
    NSInteger len = 0;
    len = [inputStream read:buf maxLength:1024];
    if(len)
    {
        [data appendBytes:(const void *)buf length:len];
        bytesRead += len;
        
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([self processInternalMessage:dic])
        {
            //
        }
        
        //Inform delegate
        else if ([self.delegate respondsToSelector:@selector(bonjourServerDidRecieveData:)])
        {
            [self.delegate bonjourServerDidRecieveData:dic];
        }
    }
    else
    {
        NSLog(@"ABBonjourServer WARNING -> inputStreamHasData: -> No Buffer.");
    }
}

-(BOOL) processInternalMessage:(NSDictionary*)dic
{
    NSString *message = [dic safeObjectForKey:@"internalMessage"];
    
    //Client Did Connect
    if (message && [message isEqualToString:INTERNAL_CLIENT_DID_CONNECT])
    {
        //Change state & inform delegate
        _lastConnectedDeviceName = [dic safeObjectForKey:@"senderDeviceName"];
        if ([self.delegate respondsToSelector:@selector(bonjourServerDidChangeLastConnectedDeviceName:)])
        {
            [self.delegate bonjourServerDidChangeLastConnectedDeviceName:self.lastConnectedDeviceName];
        }
        return YES;
    }
    return NO;
}



#pragma mark - NSStreamDelegate
-(void) stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventNone:
            if(ABBONJOURSERVER_LOGGING) NSLog(@"ABBonjourServer (NSStreamDelegate) -> NSStreamEventNone");
            break;
        case NSStreamEventOpenCompleted:
            if(ABBONJOURSERVER_LOGGING) NSLog(@"ABBonjourServer (NSStreamDelegate) -> NSStreamEventOpenCompleted");
            break;
        case NSStreamEventHasBytesAvailable:
        {
            if(ABBONJOURSERVER_LOGGING) NSLog(@"ABBonjourServer (NSStreamDelegate) -> NSStreamEventHasBytesAvailable");
            
            //Process data
            [self inputStreamHasData:(NSInputStream*)aStream];
            
            break;
        }
        case NSStreamEventHasSpaceAvailable:
            if(ABBONJOURSERVER_LOGGING) NSLog(@"ABBonjourServer (NSStreamDelegate) -> NSStreamEventHasSpaceAvailable");
            break;
        case NSStreamEventErrorOccurred:
            if(ABBONJOURSERVER_LOGGING) NSLog(@"ABBonjourServer (NSStreamDelegate) -> NSStreamEventErrorOccurred -> %@", aStream.streamError);
            break;
        case NSStreamEventEndEncountered:
            if(ABBONJOURSERVER_LOGGING) NSLog(@"ABBonjourClient (NSStreamDelegate) -> NSStreamEventEndEncountered");
            
            if (_mode == ABBonjourServerModeClient)
            {
                [self closeClientConnection];
            }
            
            break;
        default:
            break;
    }
}



#pragma mark - NSNetServiceBrowserDelegate
-(void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing
{
    NSLog(@"%s ----> %@", __PRETTY_FUNCTION__, domainString);
}

-(void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    NSLog(@"ABBonjourClient (NSNetServiceBrowser) -> didFindService: %@", aNetService.name);
    
    [_foundServices addObject:aNetService];
    
    aNetService.delegate = self;
    [aNetService resolveWithTimeout:0];
}

-(void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didNotSearch:(NSDictionary *)errorDict
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if ([_foundServices containsObject:aNetService])
    {
        [_foundServices removeObject:aNetService];
    }
    
    if ([_resolvedServices containsObject:aNetService])
    {
        [_resolvedServices removeObject:aNetService];
    }
    
    //Execute block
    if (_searchBlock)
    {
        _searchBlock(_resolvedServices);
    }
}

-(void) netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)aNetServiceBrowser
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceBrowserWillSearch:(NSNetServiceBrowser *)aNetServiceBrowser
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



#pragma mark - NSNetServiceDelegate
-(void) netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceDidPublish:(NSNetService *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceDidResolveAddress:(NSNetService *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [_foundServices removeObject:sender];
    if (![_resolvedServices containsObject:sender])
    {
        [_resolvedServices addObject:sender];
    }
    
    //Execute block
    if (_searchBlock)
    {
        _searchBlock(_resolvedServices);
    }
}

-(void) netServiceDidStop:(NSNetService *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceWillPublish:(NSNetService *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) netServiceWillResolve:(NSNetService *)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



#pragma mark - Socket / Stream Setup
-(in_port_t) setupSocket
{
    // Setup Sockets
    int fdIPV4 = socket(AF_INET, SOCK_STREAM, 0);
    
    struct sockaddr_in sin;
    memset(&sin, 0, sizeof(sin));
    sin.sin_family = AF_INET;
    sin.sin_len = sizeof(sin);
    sin.sin_port = 0;
    
    int x = 1;
    setsockopt(fdIPV4, SOL_SOCKET, SO_REUSEADDR, (void *)&x, sizeof(x));
    
    if (bind(fdIPV4, (const struct sockaddr *)&sin, sin.sin_len) != kCFSocketSuccess) {
    }
    
    socklen_t sinLen = sizeof(sin);
    if (getsockname(fdIPV4, (struct sockaddr *)&sin, &sinLen) != kCFSocketSuccess) {
    }
    
    if (listen(fdIPV4, 10) != kCFSocketSuccess) {
    }
    
    CFSocketContext context = { 0, (__bridge void *)self, NULL, NULL, NULL };
    CFSocketRef socketRef;
    CFRunLoopSourceRef runLoopRef;
    
    socketRef = CFSocketCreateWithNative(NULL, fdIPV4, kCFSocketAcceptCallBack, ListeningSocketCallBack, &context);
    runLoopRef = CFSocketCreateRunLoopSource(NULL, socketRef, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopRef, kCFRunLoopCommonModes);
    
    CFRelease(runLoopRef);
    CFRelease(socketRef);
    
    _socketDescriptor = fdIPV4;
    
    return sin.sin_port;
}

- (NSStream *) setupAndOpenStream:(NSStream *)stream
{
    stream.delegate = self;
    [stream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [stream open];
    return stream;
}

- (void) connectSocket:(int)socket toInputStream:(NSInputStream *)inStream outputStream:(NSOutputStream *)outStream;
{
    _socketDescriptor = socket;
    _inputStream = (NSInputStream *)[self setupAndOpenStream:inStream];
    _outputStream = (NSOutputStream *)[self setupAndOpenStream:outStream];
}

static void ListeningSocketCallBack(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info)
{
    int fd = *(const int *)data;
    ABBonjourServer *server = (__bridge ABBonjourServer *)info;
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    
    CFStreamCreatePairWithSocket(NULL, fd, &readStream, &writeStream);
    
    inputStream = CFBridgingRelease(readStream);
    outputStream = CFBridgingRelease(writeStream);
    
    [inputStream setProperty:(id)kCFBooleanTrue forKey:(NSString *)kCFStreamPropertyShouldCloseNativeSocket];
    [outputStream setProperty:(id)kCFBooleanTrue forKey:(NSString *)kCFStreamPropertyShouldCloseNativeSocket];
    
    [server connectSocket:fd toInputStream:inputStream outputStream:outputStream];
}


@end
