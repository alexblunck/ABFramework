//
//  ABBonjourServer.h
//  ABFramework
//
//  Created by Alexander Blunck on 5/10/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ABBONJOURSERVER_LOGGING
#define ABBONJOURSERVER_LOGGING 0
#endif

typedef void (^ABBonjourServerSearchBlock) (NSArray *foundServices);
typedef void (^ABBonjourServerConnectBlock) (BOOL success);

/**
 * ABBonjourServerDelegate
 */
@protocol ABBonjourServerDelegate <NSObject>
@optional
-(void) bonjourServerDidRecieveData:(NSDictionary*)dic;
-(void) bonjourServerDidChangeLastConnectedDeviceName:(NSString*)deviceName;
-(void) bonjourServerClientWillDisconnect;
@end


/**
 * ABBonjourServer
 */
@interface ABBonjourServer : NSObject

/**
 * Server
 */
//Start a server
+(id) startServerWithName:(NSString*)name;


/**
 * Client
 */
//Start client and search for published servers (services) with a specific name
+(id) startClientForServerWithName:(NSString*)name foundServers:(ABBonjourServerSearchBlock)block;

-(void) searchForServerWithName:(NSString*)name foundServers:(ABBonjourServerSearchBlock)block;

//Connect to a NSNetService provided by the "startClientForServerWithName:foundServers:" method
-(void) connectToService:(NSNetService*)aNetService completion:(ABBonjourServerConnectBlock)block;

-(void) closeClientConnection;




/**
 * Exchanging Data
 */
-(void) sendDictionary:(NSDictionary*)dic;


@property (nonatomic, weak) id <ABBonjourServerDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *lastConnectedDeviceName;

@end
