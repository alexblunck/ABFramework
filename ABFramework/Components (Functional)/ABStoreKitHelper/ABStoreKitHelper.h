//
//  ABStoreKitHelper.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ABSKH_LOG 1

/**
 * Types Def's
 */
typedef enum {
    ABStoreKitItemTypeNone,
    ABStoreKitItemTypeConsumable,
    ABStoreKitItemTypeNonConsumable,
    ABStoreKitItemTypeAutoRenewableSubscription,
    ABStoreKitItemTypeNonRenewingSubscription,
    ABStoreKitItemTypeFreeSubscription
}ABStoreKitItemType;

typedef enum {
    ABStoreKitErrorNone,
    ABStoreKitErrorPurchaseNotAllowed,
    ABStoreKitErrorProductNotValidated,
    ABStoreKitErrorGeneral
}
ABStoreKitError;

typedef void (^ABStoreKitBlock) (NSString *productIdentifier, BOOL successful, ABStoreKitError error);
typedef void (^ABStoreKitRestoreBlock) (NSArray *restoredItems, BOOL hasProducts, ABStoreKitError error);



/**
 * ABStoreKitItem
 */
@interface ABStoreKitItem : NSObject <NSCoding>

+(id) itemWithProductIdentifier:(NSString*)productIdentifier type:(ABStoreKitItemType)type;

@property (nonatomic, assign) ABStoreKitItemType type;
@property (nonatomic, copy) NSString *productIdentifier;
@property (nonatomic, copy) NSString *transactionIdentifier;
@property (nonatomic, strong) NSDate *transactionDate;

//Subscription Specific
@property (nonatomic, assign) NSTimeInterval subscriptionTimeInterval;

@end



/**
 * ABStoreKitHelper
 */
@interface ABStoreKitHelper : NSObject
{
    //
}

/**
 * Call this once on launch to setup everything up (don't forget to set "storeKitItems"),
 * actually why not do it in same step: [[ABStoreKitHelper sharedHelper] setStoreKitItems:...];
 */
+ (id) sharedHelper;


/**
 * Returns YES if a specfic product was purchased
 */
-(BOOL) isPurchased:(NSString*)productIdentifier;


/**
 * Returns YES if a subscription is still active (Offline check)
 */
-(BOOL) isSubscriptionActive:(NSString*)productIdentifier;


/**
 * Returns an array of ABStoreKitItem's for a subscription product identifier, if it has been purchased/restored (nil otherwise)
 *
 * If an Auto-Renewable subscription was renewed atleast once this array will contain multiple instances of ABStoreKitItem's
 * with the same product identifier with alternating "transactionDate"'s
 */
-(NSArray*) purchasedInstancesOfSubscription:(NSString*)productIdentifier;


/**
 * Perform a purchase request
 */
-(void) purchaseProduct:(NSString*)productIdentifier block:(ABStoreKitBlock)block;


/**
 * Restore all previous purchases
 */
-(void) restorePurchases:(ABStoreKitRestoreBlock)block;


/**
 * Set of ABStoreKitItem's, you need to set all you intend to use!
 */
@property (nonatomic, strong) NSSet *storeKitItems;

@end