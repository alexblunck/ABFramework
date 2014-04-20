//
//  NSNetService+ABFramework.m
//  
//
//  Created by Alexander Blunck on 19/04/14.
//
//

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#import "NSNetService+ABFramework.h"

@implementation NSNetService (ABFramework)

-(NSString*) ipAddress
{
    for (NSData *address in self.addresses)
    {
        struct sockaddr_in *socketAddress = (struct sockaddr_in *) [address bytes];
        
        NSString *ip = [NSString stringWithUTF8String:inet_ntoa(socketAddress->sin_addr)];
        
        if (![ip isEqualToString:@"0.0.0.0"])
        {
            return ip;
        }
    }
    
    return nil;
}

@end
