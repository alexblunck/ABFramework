//
//  ABFramework.h
//  ABFramework
//
//  Created by Alexander Blunck on 9/5/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#define ABFRAMEWORK_VERSION 0.0.1
#define ABFRAMEWORK_LAST_EDIT @"24.04.2013 - 00:40"

#ifndef ABFRAMEWORK_LOGGING
#define ABFRAMEWORK_LOGGING 1
#endif

/*
 UTILITIES
 */
#import "ABUtilities.h"
#import "ABTypes.h"
#import "ABMacros.h"
#import "ABReachability.h"
#import "ABFrame.h"
#import "ABCommon.h"
#import "ABMath.h"

/**
 * Protocols
 */
#import "ABViewSelectionProtocol.h"


/*
CONTAINERS
*/
#import "ABPair.h"
#import "ABPrimitiveArray.h"



/*
 MODEL
 */
#import "ABDateDescriptor.h"



/*
 CATEGORIES
 */
#import "NSData+ABFramework.h"
#import "NSDate+ABFramework.h"
#import "NSDateComponents+ABFramework.h"
#import "UIImage+ABFramework.h"
#import "NSDictionary+ABFramework.h"
#import "NSMutableDictionary+ABFramework.h"
#import "NSString+ABFramework.h"
#import "NSObject+ABFramework.h"
#import "UILabel+ABFramework.h"
#import "UIView+ABFramework.h"
#import "UIColor+ABFramework.h"
#import "UIImageView+ABFramework.h"
#import "UIViewController+ABFramework.h"
#import "NSArray+ABFramework.h"


/*
 SUB CLASSES
 */
#import "ABView.h"
#import "ABViewController.h"
#import "ABNavigationController.h"



/*
 COMPONENTS
 */
    //Functional
    #import "ABSaveSystem.h"
    #import "ABStoreKitHelper.h"
    #import "ABFileHelper.h"
    #import "ABNewsstandHelper.h"
    #import "ABNetworking.h"
    #import "ABNotificationHelper.h"
    //View
    #import "ABAlertView.h"
    #import "ABDatePickerView.h"
    #import "ABImagePickerViewController.h"
    #import "ABSelectView.h"
    #import "ABSelectViewItem.h"
    #import "ABSelectViewTheme.h"
    #import "ABSwitch.h"
    #import "ABTabBar.h"
    #import "ABTabBarController.h"
    #import "ABTabBarItem.h"
    #import "ABTabButton.h"
    #import "ABStackController.h"
    #import "ABTableStackController.h"
    #import "ABLabel.h"
    #import "ABButton.h"
    #import "ABTextField.h"
    #import "ABImageView.h"
    #import "ABHud.h"
    #import "ABFlexibleView.h"
    #import "ABSeperator.h"
    #import "ABEntypoView.h"
    #import "ABActivityView.h"
    #import "ABTapGestureRecognizer.h"
    #import "ABSwipeGestureRecognizer.h"
    #import "ABInfiniteView.h"
