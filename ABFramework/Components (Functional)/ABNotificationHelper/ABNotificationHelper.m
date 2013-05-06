//
//  ABNotificationHelper.m
//  ABFramework
//
//  Created by Alexander Blunck on 4/4/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABNotificationHelper.h"

@implementation ABNotificationHelper

#pragma mark - Local Notifications
+(void) scheduleLocalNotification:(NSString*)message date:(NSDate*)date identifier:(NSString*)identifier
{
    [self scheduleLocalNotification:message date:date identifier:identifier timeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
}

+(void) scheduleLocalNotification:(NSString*)message date:(NSDate*)date identifier:(NSString*)identifier timeZone:(NSTimeZone*)timeZone
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = message;
    notification.timeZone = timeZone;
    notification.fireDate = date;
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //Mark notification with identifier
    notification.userInfo = @{@"identifier" : identifier};
    
    //Schedule notification
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    if (ABFRAMEWORK_LOGGING) NSLog(@"ABNotificationHelper: Scheduled -> Id:%@ - Message:%@ - Date:%@", identifier, message, notification.fireDate);
}

+(void) unscheduleLocalNotification:(NSString*)identifier
{
    //Retrieve notification for identifier
    for (UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications])
    {
        if ([[notification.userInfo objectForKey:@"identifier"] isEqualToString:identifier])
        {
            //Unschedule notification
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            if (ABFRAMEWORK_LOGGING) NSLog(@"ABNotificationHelper: UNScheduled -> Id:%@ - Message:%@ - Date:%@", identifier, notification.alertBody, notification.fireDate);
        }
    }
}

+(void) unscheduleAllLocalNotifications
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if (ABFRAMEWORK_LOGGING) NSLog(@"ABNotificationHelper: UNScheduled %i notifications", notifications.count);
}

+(void) logAllLocalNotifications
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    if (notifications.count == 0)
    {
        NSLog(@"ABNotificationHelper: logAllLocalNotifications -> No notifications scheduled");
        return;
    }
    
    NSLog(@"ABNotificationHelper: logAllLocalNotifications -> START");
    for (UILocalNotification *notification in notifications)
    {
        NSString *identifier = [[notification userInfo] objectForKey:@"identifier"];
        NSLog(@"ABNotificationHelper: logAllLocalNotifications -> Id:%@ - Message:%@ - Date:%@", identifier, notification.alertBody, notification.fireDate);
    }
    NSLog(@"ABNotificationHelper: logAllLocalNotifications -> END");
}

@end
