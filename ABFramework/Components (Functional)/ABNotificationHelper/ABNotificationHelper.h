//
//  ABNotificationHelper.h
//  ComingUp iOS
//
//  Created by Alexander Blunck on 4/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABNotificationHelper : NSObject

//Local Notifications
+(void) scheduleLocalNotification:(NSString*)message date:(NSDate*)date identifier:(NSString*)identifier;
+(void) unscheduleLocalNotification:(NSString*)identifier;
+(void) unscheduleAllLocalNotifications;
+(void) logAllLocalNotifications;

@end
