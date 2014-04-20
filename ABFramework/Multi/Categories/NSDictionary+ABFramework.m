//
//  NSDictionary+ABFramework.m
//  ABFramework
//
//  Created by Alexander Blunck on 1/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "NSDictionary+ABFramework.h"

@implementation NSDictionary (ABFramework)

-(id) safeObjectForKey:(id)key
{
    id anObject = [self objectForKey:key];
    if (anObject != nil && anObject != [NSNull null] && anObject != NULL) {
        return  anObject;
    }
    return nil;
}

-(NSString*) httpBodyString
{
    //Construct requestBody String from Dic
    NSMutableString *requestBody = [NSMutableString new];
    __block NSInteger ctr = 0;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         //NSString -> url encode
         if ([obj isKindOfClass:[NSString class]])
         {
             obj = [obj asciiEncodedString];
         }
         
         [requestBody appendFormat:@"%@=%@", key, obj];
         
         if (ctr < self.count - 1)
         {
             [requestBody appendString:@"&"];
         }
         
         ctr++;
     }];
    
    return requestBody;
}

-(NSString*) jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
