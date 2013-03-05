//
//  ABStoreKitHelper.m
//  ABFramework
//
//  Created by Alexander Blunck on 2/23/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABStoreKitHelper.h"

//APPLE FRAMEWORKS
#import <StoreKit/StoreKit.h>

@interface ABStoreKitHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    NSMutableSet *_validatedProducts;
    NSMutableDictionary *_blockDictionary;
}
@end

@implementation ABStoreKitHelper

#pragma mark - Utility
+ (id)sharedHelper
{
    static dispatch_once_t pred;
    static ABStoreKitHelper *helper = nil;
    
    dispatch_once(&pred, ^{ helper = [[self alloc] init]; });
    return helper;
}



#pragma mark - Initializer
- (id)init {
    if ((self = [super init]))
    {
        NSLog(@"ABStoreKitHelper: Started");
        
        //Allocation
        _validatedProducts = [NSMutableSet new];
        _productIdentifiers = [NSMutableSet new];
        _blockDictionary = [NSMutableDictionary new];
        
        //Add SKPaymentTransactionObserver
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}



#pragma mark - Product Validation
-(void) getNewProductData
{
    if (![self allProductsValidated])
    {
        NSLog(@"ABStoreKitHelper: Checking if Product Identifiers are valid...");
        
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productIdentifiers];
        request.delegate = self;
        [request start];
        
        [self performSelector:@selector(getNewProductData) withObject:nil afterDelay:30];
    }
}



#pragma mark - Helper
-(BOOL) isPurchased:(NSString*)productIdentifier
{
    return [self loadBoolForKey:productIdentifier];
}

-(BOOL) allProductsValidated
{
    //Loop through all productIdentifiers
    for (NSString *productIdentifier in self.productIdentifiers)
    {
        //Return NO if one product with productIdentifier doesn't exist
        if (![self productValidated:productIdentifier])
        {
            return NO;
        }
    }
    //Return YES if all products in productIdentifiers array were found
    return YES;
}

-(BOOL) productValidated:(NSString*)productIdentifier
{
    //Loop through all validated productsr
    for (SKProduct *product in _validatedProducts)
    {
        //Return YES if product with productIdentifier exists
        if ([product.productIdentifier isEqualToString:productIdentifier])
        {
            return YES;
        }
    }
    //..Else return NO
    return NO;
}



#pragma mark - Purchase
-(void) purchaseProduct:(NSString*)productIdentifier block:(ABStoreKitBlock)block
{
    //Check if user is allowed to make payments (e.g. Parental Settings)
    if (![SKPaymentQueue canMakePayments])
    {
        //Execute block
        block(productIdentifier, NO, ABStoreKitErrorPurchaseNotAllowed);
        
        return;
    }
    
    //Make sure product about to be purchased has been validated
    if ([self productValidated:productIdentifier])
    {
        SKProduct *productToBuy;
        for (SKProduct *product in _validatedProducts)
        {
            if ([product.productIdentifier isEqualToString:productIdentifier])
            {
                productToBuy = product;
            }
        }
        
        //Add Block to block dictionary
        [_blockDictionary setObject:[block copy] forKey:productIdentifier];
        
        //Purchase request
        SKPayment *payment = [SKPayment paymentWithProduct:productToBuy];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        //Execute block
        block(productIdentifier, NO, ABStoreKitErrorProductNotValidated);
    }
    
}



#pragma mark - Restore
-(void) restorePurchases:(ABStoreKitRestoreBlock)block
{
    //Add Block to block dictionary
    [_blockDictionary setObject:[block copy] forKey:@"ABStorekitHelper.restoreBlock"];
    
    //Start restore request
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}



#pragma mark - SKProductsRequestDelegate 
-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //Add returned SKProduct's to validatedProducts set
    for (SKProduct *product in response.products)
    {
        [_validatedProducts addObject:product];
    }
    
    //Log
    for (NSString *productIdentifier in self.productIdentifiers)
    {
        if ([self productValidated:productIdentifier])
        {
            NSLog(@"ABStoreKitHelper: ProductIdentifier: %@ is Valid!", productIdentifier);
        }
        else
        {
            NSLog(@"ABStoreKitHelper: ProductIdentifier: %@ is NOT Valid!", productIdentifier);
        }
    }
}



#pragma mark SKPaymentTransactionObserver Methods
-(void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        NSString *transactionUpdate;
        
        switch (transaction.transactionState)
        {
            //FAILED
            case SKPaymentTransactionStateFailed:
            {
                transactionUpdate = @"FAILED";
                [queue finishTransaction:transaction];
                //Execute block
                ABStoreKitBlock block = [_blockDictionary objectForKey:transaction.payment.productIdentifier];
                if (block)
                {
                    block(transaction.payment.productIdentifier, NO, ABStoreKitErrorGeneral);
                }
                //Remove from block dictionary
                [_blockDictionary removeObjectForKey:transaction.payment.productIdentifier];
                
                break;
            }
            
            //PURCHASED
            case SKPaymentTransactionStatePurchased:
            {
                transactionUpdate = @"PURCHASED";
                [queue finishTransaction:transaction];
                //Mark as purchased
                [self saveBool:YES withKey:transaction.payment.productIdentifier];
                //Execute block
                ABStoreKitBlock block = [_blockDictionary objectForKey:transaction.payment.productIdentifier];
                if (block)
                {
                    block(transaction.payment.productIdentifier, YES, ABStoreKitErrorNone);
                }
                //Remove from block dictionary
                [_blockDictionary removeObjectForKey:transaction.payment.productIdentifier];
                
                break;
            }
            
            //PURCHASING
            case SKPaymentTransactionStatePurchasing:
            {
                transactionUpdate = @"PURCHASING";
                break;
            }
            
            //RESTORED
            case SKPaymentTransactionStateRestored:
            {
                transactionUpdate = @"RESTORED";
                [queue finishTransaction:transaction];
                //Execute block
                ABStoreKitRestoreBlock block = [_blockDictionary objectForKey:@"ABStorekitHelper.restoreBlock"];
                if (block)
                {
                    block(transaction.payment.productIdentifier, NO, YES, ABStoreKitErrorNone);
                }
                
                break;
            }
            
            //DEFAULT
            default:
            {
                break;
            }
        }
        
        NSLog(@"ABStoreKitHelper: TransactionState -> %@ (%@)", transaction.payment.productIdentifier, transactionUpdate);
    }
    
}

-(void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue*) queue
{
    //No products to restore
    if (!queue.transactions || [queue.transactions count] == 0)
    {
        //Execute block
        ABStoreKitRestoreBlock block = [_blockDictionary objectForKey:@"ABStorekitHelper.restoreBlock"];
        if (block)
        {
            block(nil, YES, NO, ABStoreKitErrorNone);
        }
    }
    //Mark non-consumable IAP as restored & check if subscriptions are still active
    else
    {
        //Keep track if anything was restored at all
        BOOL restoredSomething = NO;
        
        for (SKPaymentTransaction *transaction in queue.transactions)
        {
            if (transaction.transactionState == SKPaymentTransactionStateRestored || transaction.transactionState == SKPaymentTransactionStatePurchased)
            {
                BOOL shouldRestore = NO;
                
                NSData *transactionReciept = transaction.transactionReceipt;
                NSString *recieptString = [[NSString alloc] initWithData:transactionReciept encoding:NSUTF8StringEncoding];
                //NSDate *transactionDate = transaction.transactionDate;
                
                NSLog(@"%@", recieptString);
                
                //IF SUBSCRIPTION
                //Implement detection if subscription is still active at current time (use server?)
                //and only restore it if it is
                //Current time (unix timestamp)
                //Calculate subscription expiration date: transaction.transactionDate(unix) + subscriptionLengthInSeconds
                //Get purchase date: transaction.transactionDate(unix)
                //if subscription expiration date is in the future, restore it
                shouldRestore = YES;

                //ELSE (consumable IAP) (always restore)
                shouldRestore = YES;
                
                //Mark as purchased
                if (shouldRestore)
                {
                    [self saveBool:YES withKey:transaction.payment.productIdentifier];
                    
                    //Did restore something
                    restoredSomething = YES;
                }
            }
        }
        
        //Execute block
        ABStoreKitRestoreBlock block = [_blockDictionary objectForKey:@"ABStorekitHelper.restoreBlock"];
        
        //Did restore something
        if (block && restoredSomething)
        {
            block(nil, YES, YES, ABStoreKitErrorNone);
        }
        //Did NOT restpre anything
        else if (block && !restoredSomething)
        {
            block(nil, YES, NO, ABStoreKitErrorNone);
        }
    }
    
    //Remove block from block dictionary
    [_blockDictionary removeObjectForKey:@"ABStorekitHelper.restoreBlock"];
}

-(void) paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    //Execute block
    ABStoreKitRestoreBlock block = [_blockDictionary objectForKey:@"ABStorekitHelper.restoreBlock"];
    if (block)
    {
        block(nil, YES, NO, ABStoreKitErrorGeneral);
    }
}

-(void) paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    //NSLog(@"ABStoreKitHelper: Removed Transactions from Payment Queue");
}



#pragma mark - Data Persistence
-(void) saveBool:(BOOL)boolean withKey:(NSString*)key
{
    NSNumber *boolNumber = [NSNumber numberWithBool:boolean];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:boolNumber];
    [ABSaveSystem saveData:data key:key encryption:YES];
}

-(BOOL) loadBoolForKey:(NSString*)key
{
    NSData *data = [ABSaveSystem dataForKey:key encryption:YES];
    if (data != nil)
    {
        NSNumber *boolean = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return [boolean boolValue];
    }
    return NO;
}



#pragma mark - Accessors
-(void) setProductIdentifiers:(NSMutableSet *)productIdentifiers
{
    _productIdentifiers = productIdentifiers;
    
    if (_productIdentifiers.count != 0)
    {
        [self getNewProductData];
    }
}

@end