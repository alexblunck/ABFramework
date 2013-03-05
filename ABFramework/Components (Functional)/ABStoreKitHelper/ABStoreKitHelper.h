//
//  ABStoreKitHelper.h
//  ABFramework
//
//  Created by Alexander Blunck on 2/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ABStoreKitErrorNone,
    ABStoreKitErrorPurchaseNotAllowed,
    ABStoreKitErrorProductNotValidated,
    ABStoreKitErrorGeneral
}
ABStoreKitError;

typedef void (^ABStoreKitBlock) (NSString *productIdentifier, BOOL successful, ABStoreKitError error);
typedef void (^ABStoreKitRestoreBlock) (NSString *productIdentifier, BOOL restoreDone, BOOL hasProducts, ABStoreKitError error);
 
@interface ABStoreKitHelper : NSObject
{
    //
}

/**
 * Call this once on launch to setup everything up (don't forget to set "productIdentifiers")
 */
+ (id) sharedHelper;


/**
 * Returns YES if a specfic product was already purchased
 */
-(BOOL) isPurchased:(NSString*)productIdentifier;


/**
 * Perform a purchase request
 */
-(void) purchaseProduct:(NSString*)productIdentifier block:(ABStoreKitBlock)block;


/**
 * Restore all previous purchases
 */
-(void) restorePurchases:(ABStoreKitRestoreBlock)block;


/**
 * Set of product identifiers, you need to set all you intend to use!
 */
@property (nonatomic, strong) NSSet *productIdentifiers;

@end